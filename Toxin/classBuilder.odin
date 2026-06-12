#+feature using-stmt
package Toxin

import "base:runtime"
import GDE "../GDWrapper/gdAPI/gdextension"
import GDW "../GDWrapper"
import "../GDWrapper/gdAPI"
import Classes "../GD_Classes"
import sics "base:intrinsics"
import "core:fmt"
import "core:mem"
import "core:reflect"
import "base:builtin"
import "core:c"


/*
* Details for the class. Used for registration or to create directly from Odin's side.
* Fields populated by the user: self_register; init_level; GDClass_Index; class_struct; binder; vtable;
* registerer: the registration procedure to use for this class
* create: The procedure called after the memory has been allocated. This is called during the class init process, before _ready and is used to set defaults and init heap memory.
* destroy: The procedure called before the memory is destroyed. This is called during the destruction phased and is used to delete any heap allocated memory or other cleanup as needed.
* class_struct: the type of the struct being used as the class struct.
* init_level: Godot's initialization level at which this class should be registered. (Some Node types are not available until a later time in Godot's initialization.)
* GDClass_Index: the enum value representing the Godot Node to build off of. Such as .Node2D; .Object; .CharacterBody2D
* vtable: pointer to the vtable of procedures. vtable would hold Godot class virtuals such as _process; _ready; _input.
* GDClass_StringName: pointer to the StringName value representing the Godot Node. Will be populated by the Register procedure based on the GDClass_Index value.
* SN: StringName representing the name of your class. Should be used to request instantiation from Godot as well as other Godot interactions. Will be populated by Register procedure.
* binder: procedure to call in order to export the values you would like to expose to Godot. Variables, procedures, etc via Export; Export_Range
*/
Class_Deets :: struct {
    using required: required_deets,
    create: proc(userdata: ^Class_Deets, self: rawptr), //Cast to the Object class that your class extends.
    destroy: proc(userdata: ^Class_Deets, self: rawptr),
    vtable: rawptr,
    notification: GDE.ClassNotification2,
    GDClass_StringName: ^StringName,
    SN : StringName,
    Exporter: proc(className: ^StringName),
    GD_Binding_Callbacks: GDE.InstanceBindingCallbacks, //see classBindingCallbacks for details
}


required_deets:: struct #all_or_none{
    registerer: proc(self: ^required_deets, init_level: InitializationLevel), //Keep as first value in order to trivially cast it.
    class_struct_size: i64,
    init_level: InitializationLevel,
    GDClass_Index: Classes.ClassName_Index,
    name: string,
}

/*
* Function used to register a custom class with Godot. This will use the information provided in class_info or default to bltn equivalents.
* This will need to be called by you at some point during your extension's initialization. Typically this is done via the registerer method of your Class_Deets struct.
* deets: the struct describing the class which you are registering.
* init_level: the current initialization level of Godot's startup procedure.
* class_info: the information about the class which you would like to use when customizing.
*/
_Register :: proc(deets: ^Class_Deets, init_level: InitializationLevel= .INITIALIZATION_SCENE, \
    class_info: GDE.ClassCreationInfo4 = class_info_Default) {
    
    assert(deets != nil, "Register procedure received a nil value for deets. This should never happen.")
    // If this check fails, then you did not put the registration call in the correct init level of the extensionInit proc.
    assert(deets.required.init_level == init_level, fmt.aprintf("Class %s init function called at a different level than was expected.", deets.required.name))


    //review definition of GDE.ClassCreationInfo4 for more details on each field.
    class_info: GDE.ClassCreationInfo4 = class_info

    if class_info.icon_path == nil {
        //string to a svg which will be used as an icon for your Nodes.
        //Must be NewLatin. UTF8 does not work :/
        stringraw:gdstring
        gdAPI.Strings_Utils.NewWithLatin1Chars(&stringraw, "res://icon.svg")
        class_info.icon_path = &stringraw
    }
    if class_info.create_instance_func == nil {
        class_info.create_instance_func = cast(GDE.ClassCreateInstance2)bltn_Create
    }
    if class_info.free_instance_func == nil {
        class_info.free_instance_func = cast(GDE.ClassFreeInstance)bltn_Destroy
    }
    class_info.class_userdata = deets
    class_info.notification_func = deets.notification

    if (deets.vtable != nil) {
        Classes.virtuals_init[deets.GDClass_Index]()
        class_info.get_virtual_func = cast(GDE.ClassGetVirtual2)_get_virtual
    }
    
    if deets.destroy == nil {
        deets.destroy = destroy_dummy
    }
    if deets.create == nil {
        deets.create = create_dummy
    }

    //Matching the name to the class struct is vital as it will be used in most binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct(&deets.SN, deets.required.name)
    deets.GDClass_StringName = Classes.GDClass_StringName_get(deets.required.GDClass_Index)
    gdAPI.ClassDB.RegisterExtensionClass5(Library, &deets.SN, deets.GDClass_StringName, &class_info)

    if deets.Exporter != nil {
        deets.Exporter(&deets.SN)
    }
}

unregister :: proc(class: ^Class_Deets) {
    gdAPI.ClassDB.ClassdbUnregisterExtensionClass(Library, &class.SN)
    Destroy(&class.SN)
}


//Easily get the name of the struct you are using for your class information.
get_name:: proc "contextless" (class: typeid) -> string {
    return type_info_of(class).variant.(runtime.Type_Info_Named).name
}


/*
* Contains the registering procedure. Allows customization of procedures used for create, destroy, make_get_virtual_func
* see example_self_reggy.
* This implementation of registerer allows for the shorthand class_deets->self_register(init_level)
*/
Registerer:: struct #all_or_none{
    self_register: proc(self: ^Registerer, init_level: InitializationLevel),
}

/*
* A self referencing procedure to call the Register procedure.
* self: pointer to the registerer field of the Class_Deets for this class. Should be a pointer to itself.
* init_level: The current level of Godot's initialization. Should be passed in based on the value from your entry procedure. See extensionInit
*/
example_self_reggy:: proc(self: ^Registerer, init_level: InitializationLevel) {
    me:=(^Class_Deets)(self)
    _Register(me, init_level, {})
}

//Implementation details. For a simple implementation you should only need to use the above structs and call the self referenced register proc.

/*
* TODO: not implemented.
*/
reg_list: struct {
    count: int,
    deets: [5]^Registerer,
}

/*
* Container type for the class Node.
* Self: pointer to the Godot Class as instantiated by Create.
* Will be used in Create and Destroy to allocate size and add pointer to the Godot base Node which gets created (aka Node2D)
* Will be passed into the procedures you create, as well as the virtuals that come with the Godot Node.
*/
Class_Container :: Classes.Class_Container
CC_Dummy:: struct{}


/*This runs once when the class is created before it gets added to a tree.
* construct parent class, malloc your class struct, set defaults, heap allocate variables, construct any class children.
* This is different from Godot's ready, which is called sometime after this.
* Returns a pointer to Class_Container(your_class_struct)
*/
@(deprecated="use bltn_Create or TMAlloc_Create")
Create :: proc"c"(p_class_userdata: ^Class_Deets, p_notify_postinitialize: Bool) -> (^Object) {
    context = runtime.default_context()

    object: GDE.ObjectPtr = gdAPI.ClassDB.ConstructObject(p_class_userdata.GDClass_StringName)

    //Create our containing struct.
    self:^Class_Container(CC_Dummy)
    if TMAlloc == nil {
        //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
        self = cast(^Class_Container(CC_Dummy))gdAPI.Memory_Uils.MemAlloc(int(p_class_userdata.required.class_struct_size) + size_of(^Object))
    } else {
        self = cast(^Class_Container(CC_Dummy))TMAlloc(p_class_userdata, Int(p_class_userdata.required.class_struct_size) + size_of(^Object))
    }
    mem.set(self, 0, int(p_class_userdata.required.class_struct_size) + size_of(^Object))
    self.self= object

    if p_class_userdata.create != nil {
        p_class_userdata.create(p_class_userdata, self)
    }

    gdAPI.Object_Utils.SetInstance(object, &p_class_userdata.SN, cast(GDE.ClassInstancePtr)self)
    gdAPI.Object_Utils.SetInstanceBinding(object, Library, self, &p_class_userdata.GD_Binding_Callbacks)

    return object
}

/*
* Called by User, bltn_Create, TMAlloc_Create
* bltn_Create, TMAlloc_Create will automatically call this method. If you are not owning the allocation portion you can ignore this exists.
*/

Create2 :: proc "c" (p_class_userdata: ^Class_Deets, p_notify_postinitialize: Bool, class_obj: ^Class_Container(CC_Dummy)) -> (^Object) {
    context = runtime.default_context()

    object: GDE.ObjectPtr = gdAPI.ClassDB.ConstructObject(p_class_userdata.GDClass_StringName)
    class_obj.self= object

    p_class_userdata.create(p_class_userdata, class_obj)

    gdAPI.Object_Utils.SetInstance(object, &p_class_userdata.SN, cast(GDE.ClassInstancePtr)class_obj)
    gdAPI.Object_Utils.SetInstanceBinding(object, Library, class_obj, &p_class_userdata.GD_Binding_Callbacks)

    return object
}
create_dummy :: proc(userdata: ^Class_Deets, self: rawptr) {}

//Called by Godot
//This is the default constructor used

bltn_Create :: proc "c" (p_class_userdata: ^Class_Deets, p_notify_postinitialize: Bool) -> (^Object) {
    context = runtime.default_context()

    //Create our containing struct.
    self:^Class_Container(CC_Dummy)
    self = cast(^Class_Container(CC_Dummy))gdAPI.Memory_Uils.MemAlloc(int(p_class_userdata.required.class_struct_size) + size_of(^Object))
    mem.set(self, 0, int(p_class_userdata.required.class_struct_size) + size_of(^Object))

    return Create2(p_class_userdata, p_notify_postinitialize, self)
}

//Called by Godot
//pass to register via ClassCreateInfo to override default

TMAlloc_Create :: proc "c" (p_class_userdata: ^Class_Deets, p_notify_postinitialize: Bool) -> (^Object) {
    context = runtime.default_context()

    //Create our containing struct.
    self:^Class_Container(CC_Dummy)
    self = cast(^Class_Container(CC_Dummy))TMAlloc(p_class_userdata, Int(p_class_userdata.required.class_struct_size) + size_of(^Object))
    mem.set(self, 0, int(p_class_userdata.required.class_struct_size) + size_of(^Object))

    return Create2(p_class_userdata, p_notify_postinitialize, self)
}

Class_Init::proc "c" (p_class_user_data: ^Class_Deets, p_notify_postinitialize: Bool) -> (^Object) {
    context = runtime.default_context()
    class:= bltn_Create(p_class_user_data, p_notify_postinitialize)
    return (cast(^Class_Container(CC_Dummy))class).self
}

/*
* This is a simple callback which Godot will call in order to free memory of you class Node.
* If you have a more complicated implementation you should either wrap this in your own call or replace it completely.
* This procedure is associated with your class via the class_info struct built-up in the Register procedure.
* GDE.ClassInstancePtr is a pointer to a Class_Container(T:typeid)
//Called by Godot
*/
@(deprecated="use bltn_Destroy or TMAlloc_Destroy")
Destroy_ :: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    if p_class_userdata.destroy != nil {
        p_class_userdata.destroy(p_class_userdata, p_instance)
    }
    if TMFree != nil {
        TMFree(p_class_userdata, p_instance)
    } else {
        gdAPI.Memory_Uils.MemFree(p_instance)
    }
}

//Called by Godot

TMFree_Destroy :: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    if p_class_userdata.destroy != nil {
        p_class_userdata.destroy(p_class_userdata, p_instance)
    }
    TMFree(p_class_userdata, p_instance)
}

//Called by Godot
//This is the default destructor used

bltn_Destroy :: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    p_class_userdata.destroy(p_class_userdata, p_instance)
    gdAPI.Memory_Uils.MemFree(p_instance)
}
destroy_dummy :: proc(userdata: ^Class_Deets, self: rawptr) {}

/*
* Examples of memory which you need to delete yourself
* The heap allocated aspects of the class (dynamic arrays), along with theadditional nodes, canvasItems, area2d that you created.
* Similar to how bulletshower needs to do cleanup on the textures and phys objects.
* Removing from scene tree does not necessarily destroy a Node.
*/

/* 
* Prefer using these notifications over the virtuals. If you use virtuals GDScript will have higher priority over your own.
* This is an example with 'all' of th enotification there are from the JSON.
*/
Notifications_example :: proc "c" (p_instance: GDE.ClassInstancePtr, p_what: i32, p_reversed: b8) {
    
    what2:= Classes.Object_Constants(p_what)
    switch what2 {
    case .NOTIFICATION_POSTINITIALIZE:
    case .NOTIFICATION_PREDELETE:
    case .NOTIFICATION_EXTENSION_RELOADED:
    }
    what:= Classes.Node_Constants(p_what)
    switch what {
    case .NOTIFICATION_ENTER_TREE:
    case .NOTIFICATION_EXIT_TREE:
    case .NOTIFICATION_MOVED_IN_PARENT:
    case .NOTIFICATION_READY:
    case .NOTIFICATION_PAUSED:
    case .NOTIFICATION_UNPAUSED:
    case .NOTIFICATION_PHYSICS_PROCESS:
    case .NOTIFICATION_PROCESS:
    case .NOTIFICATION_PARENTED:
    case .NOTIFICATION_UNPARENTED:
    case .NOTIFICATION_SCENE_INSTANTIATED:
    case .NOTIFICATION_DRAG_BEGIN:
    case .NOTIFICATION_DRAG_END:
    case .NOTIFICATION_PATH_RENAMED:
    case .NOTIFICATION_CHILD_ORDER_CHANGED:
    case .NOTIFICATION_INTERNAL_PROCESS:
    case .NOTIFICATION_INTERNAL_PHYSICS_PROCESS:
    case .NOTIFICATION_POST_ENTER_TREE:
    case .NOTIFICATION_DISABLED:
    case .NOTIFICATION_ENABLED:
    case .NOTIFICATION_RESET_PHYSICS_INTERPOLATION:
    case .NOTIFICATION_EDITOR_PRE_SAVE:
    case .NOTIFICATION_EDITOR_POST_SAVE:
    case .NOTIFICATION_WM_MOUSE_ENTER:
    case .NOTIFICATION_WM_MOUSE_EXIT:
    case .NOTIFICATION_WM_WINDOW_FOCUS_IN:
    case .NOTIFICATION_WM_WINDOW_FOCUS_OUT:
    case .NOTIFICATION_WM_CLOSE_REQUEST:
    case .NOTIFICATION_WM_GO_BACK_REQUEST:
    case .NOTIFICATION_WM_SIZE_CHANGED:
    case .NOTIFICATION_WM_DPI_CHANGE:
    case .NOTIFICATION_VP_MOUSE_ENTER:
    case .NOTIFICATION_VP_MOUSE_EXIT:
    case .NOTIFICATION_WM_POSITION_CHANGED:
    case .NOTIFICATION_OS_MEMORY_WARNING:
    case .NOTIFICATION_TRANSLATION_CHANGED:
    case .NOTIFICATION_WM_ABOUT:
    case .NOTIFICATION_CRASH:
    case .NOTIFICATION_OS_IME_UPDATE:
    case .NOTIFICATION_APPLICATION_RESUMED:
    case .NOTIFICATION_APPLICATION_PAUSED:
    case .NOTIFICATION_APPLICATION_FOCUS_IN:
    case .NOTIFICATION_APPLICATION_FOCUS_OUT:
    case .NOTIFICATION_TEXT_SERVER_CHANGED:
    case .NOTIFICATION_ACCESSIBILITY_UPDATE:
    case .NOTIFICATION_ACCESSIBILITY_INVALIDATE:
    }
    what4:= Classes.Window_Constants(p_what)
    switch what4 {
    case .NOTIFICATION_VISIBILITY_CHANGED:
    case .NOTIFICATION_THEME_CHANGED:
    }
    what1:= Classes.Control_Constants(p_what)
    switch what1 {
    case .NOTIFICATION_RESIZED:
    case .NOTIFICATION_MOUSE_ENTER:
    case .NOTIFICATION_MOUSE_EXIT:
    case .NOTIFICATION_MOUSE_ENTER_SELF:
    case .NOTIFICATION_MOUSE_EXIT_SELF:
    case .NOTIFICATION_FOCUS_ENTER:
    case .NOTIFICATION_FOCUS_EXIT:
    case .NOTIFICATION_THEME_CHANGED:
    case .NOTIFICATION_SCROLL_BEGIN:
    case .NOTIFICATION_SCROLL_END:
    case .NOTIFICATION_LAYOUT_DIRECTION_CHANGED: 
    }
    what5:= Classes.Node3D_Constants(p_what)
    switch what5 {
    case .NOTIFICATION_TRANSFORM_CHANGED:
    case .NOTIFICATION_ENTER_WORLD:
    case .NOTIFICATION_EXIT_WORLD:
    case .NOTIFICATION_VISIBILITY_CHANGED:
    case .NOTIFICATION_LOCAL_TRANSFORM_CHANGED:
    }
    what3:= Classes.Skeleton3D_Constants(p_what)
    switch what3 {
    case. NOTIFICATION_UPDATE_SKELETON:
    }
    what8:= Classes.Container_Constants(p_what)
    switch what8 {
    case .NOTIFICATION_PRE_SORT_CHILDREN:
    case .NOTIFICATION_SORT_CHILDREN:
    }
    what6:= Classes.MainLoop_Constants(p_what)
    switch what6 {
    case .NOTIFICATION_OS_MEMORY_WARNING:
    case .NOTIFICATION_TRANSLATION_CHANGED:
    case .NOTIFICATION_WM_ABOUT:
    case .NOTIFICATION_CRASH:
    case .NOTIFICATION_OS_IME_UPDATE:
    case .NOTIFICATION_APPLICATION_RESUMED:
    case .NOTIFICATION_APPLICATION_PAUSED:
    case .NOTIFICATION_APPLICATION_FOCUS_IN:
    case .NOTIFICATION_APPLICATION_FOCUS_OUT:
    case .NOTIFICATION_TEXT_SERVER_CHANGED:
    }
    what7:= Classes.EditorSettings_Constants(p_what)
    switch what7 {
    case .NOTIFICATION_EDITOR_SETTINGS_CHANGED:
    }
}

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

_get_virtual::  proc "c" (p_class_userdata: ^Class_Deets, p_name: ^StringName, p_hash: u32) -> (GDE.ClassCallVirtual) {
    context = runtime.default_context()
    if p_class_userdata.vtable == nil {
        return nil
    }
    virtual:= Classes.virtuals_list[p_class_userdata.GDClass_Index](p_class_userdata.vtable, p_name, p_hash)
    return cast(GDE.ClassCallVirtual)virtual
}
