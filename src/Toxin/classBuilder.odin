#+feature using-stmt
package Toxin

import "base:runtime"
import GDE "../GDWrapper/gdAPI/gdextension"
import GDW "../GDWrapper"
import "../GDWrapper/gdAPI"
import sics "base:intrinsics"
import "core:fmt"
import "core:mem"
import "core:reflect"
import "base:builtin"
import "core:c"

/*
* Container type for the class Node.
* Self: pointer to the Godot Class as instantiated by Create.
* Will be used in Create and Destroy to allocate size and add pointer to the Godot base Node which gets created (aka Node2D)
* Will be passed into the procedures you create, as well as the virtuals that come with the Godot Node.
*/
@(tag="export")
Class_Container :: struct ($Class_Structure: typeid) #packed {
    self: ^Object, //Keep as first so it can be trivially cast.
    using class: Class_Structure,
}
CC_Dummy:: struct{}


/*
* Details for the class. Used for registration or to create directly from Odin's side.
* Fields populated by the user: self_register; init_level; GDClass_Index; class_struct; binder; vtable;
* registerer: the registration procedure to use for this class
* create: the create procedure to use for Node instantiation. Defaults to Create. Will be set with the procedure passed into the Register procedure.
* destroy: the destructor for the Node. Defaults to Destroy. Will be set with the procedure passed into the Register procedure.
* class_struct: the type of the struct being used as the class struct.
* init_level: Godot's initialization level at which this class should be registered. (Some Node types are not available until a later time in Godot's initialization.)
* GDClass_Index: the enum value representing the Godot Node to build off of. Such as .Node2D; .Object; .CharacterBody2D
* vtable: pointer to the vtable of procedures. vtable would hold Godot class virtuals such as _process; _ready; _input.
* GDClass_StringName: pointer to the StringName value representing the Godot Node. Will be populated by the Register procedure based on the GDClass_Index value.
* SN: StringName representing the name of your class. Should be used to request instantiation from Godot as well as other Godot interactions. Will be populated by Register procedure.
* binder: procedure to call in order to export the values you would like to expose to Godot. Variables, procedures, etc via Export; Export_Range
*/
Class_Deets :: struct {
    required: required_deets,
    //using registerer: Registerer, //Keep as first value in order to trivially cast it.
    create: proc(self: rawptr), //Cast to the Object class that your class extends.
    destroy: proc(self: rawptr),
    vtable: struct {
        table_type: vtable_type,
        table: rawptr,
    },
    GDClass_StringName: ^StringName,
    SN : StringName,
    Exporter: proc(className: ^StringName),
    GD_Binding_Callbacks: GDE.InstanceBindingCallbacks, //see classBindingCallbacks for details
}

get_name:: proc "contextless" (class: typeid) -> string {
    return type_info_of(class).variant.(runtime.Type_Info_Named).name
}

vtable_type:: enum i32 {
    None,
    Node,
    CanvasItem,
    CollisionObject2D,
    Texture2D,
}

required_deets:: struct #all_or_none{
    using registerer: Registerer, //Keep as first value in order to trivially cast it.
    class_struct_size: i64,
    init_level: InitializationLevel,
    GDClass_Index: GDW.ClassName_Index,
    name: string,
}

InitializationLevel :: enum {
	INITIALIZATION_CORE,
	INITIALIZATION_SERVERS,
	INITIALIZATION_SCENE,
	INITIALIZATION_EDITOR,
	MAX_INITIALIZATION_LEVEL,
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
    Register(me, init_level)
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
* These are not necessary for the custom classes, but are useful if you want to include side-effects to an object that has no association with this GDE.
* Main example is to make your own wrapper around the object through create.
* create_callback is used when get_instance_binding is unable to find the GDE associated with an object
* free_callback is called whenever the object is freed. Use for destructor side-effects (all the children are dead, kill parent)
* reference_callback called on reference. Reply if this can be destroyed.
*/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil,
};

//Optional. Toxin will default to Godot's memory if you do not provide this.
//Pass TMAlloc_Create via classCreateInfo during Registration if you use this.
@(export)
TMAlloc : proc "c" (p_class_user_data: ^Class_Deets, p_bytes: Int) -> rawptr

//Optional. Toxin will default to Godot's memory if you do not provide this.
//Pass TMAlloc_Destroy via classCreateInfo during Registration if you use this.
@(export)
TMFree : proc "c" (p_class_user_data: ^Class_Deets, p_ptr: rawptr)

/*This runs once when the class is created before it gets added to a tree.
* construct parent class, malloc your class struct, set defaults, heap allocate variables, construct any class children.
* This is different from Godot's ready, which is called sometime after this.
* Returns a pointer to Class_Container(your_class_struct)
*/
@(export)
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
        p_class_userdata.create(self)
    }

    gdAPI.Object_Utils.SetInstance(object, &p_class_userdata.SN, cast(GDE.ClassInstancePtr)self)
    gdAPI.Object_Utils.SetInstanceBinding(object, GDW.Library, self, &p_class_userdata.GD_Binding_Callbacks)

    return object
}

/*
* Called by User, bltn_Create, TMAlloc_Create
* bltn_Create, TMAlloc_Create will automatically call this method. If you are not owning the allocation portion you can ignore this exists.
*/
@(export)
Create2 :: proc "c" (p_class_userdata: ^Class_Deets, p_notify_postinitialize: Bool, class_obj: ^Class_Container(CC_Dummy)) -> (^Object) {
    context = runtime.default_context()

    object: GDE.ObjectPtr = gdAPI.ClassDB.ConstructObject(p_class_userdata.GDClass_StringName)
    class_obj.self= object

    if p_class_userdata.create != nil {
        p_class_userdata.create(class_obj)
    }

    gdAPI.Object_Utils.SetInstance(object, &p_class_userdata.SN, cast(GDE.ClassInstancePtr)class_obj)
    gdAPI.Object_Utils.SetInstanceBinding(object, GDW.Library, class_obj, &p_class_userdata.GD_Binding_Callbacks)

    return object
}

//Called by Godot
//This is the default constructor used
@(export)
bltn_Create :: proc "c" (p_class_userdata: ^Class_Deets, p_notify_postinitialize: Bool) -> (^Object) {
    context = runtime.default_context()

    //Create our containing struct.
    self:^Class_Container(CC_Dummy)
    self = cast(^Class_Container(CC_Dummy))gdAPI.Memory_Uils.MemAlloc(int(p_class_userdata.required.class_struct_size) + size_of(^Object))
    mem.set(self, 0, int(p_class_userdata.required.class_struct_size) + size_of(^Object))

    return Create2(p_class_userdata, p_notify_postinitialize, self)
}

//Called by Godot
@(export)
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
    class:= Create(p_class_user_data, p_notify_postinitialize)
    return (cast(^Class_Container(CC_Dummy))class).self
}

/*
* This is a simple callback which Godot will call in order to free memory of you class Node.
* If you have a more complicated implementation you should either wrap this in your own call or replace it completely.
* This procedure is associated with your class via the class_info struct built-up in the Register procedure.
* GDE.ClassInstancePtr is a pointer to a Class_Container(T:typeid)
//Called by Godot
*/
@(export)
Destroy :: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    if p_class_userdata.destroy != nil {
        p_class_userdata.destroy(p_instance)
    }
    if TMFree != nil {
        TMFree(p_class_userdata, p_instance)
    } else {
        gdAPI.Memory_Uils.MemFree(p_instance)
    }
}

//Called by Godot
@(export)
TMFree_Destroy :: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    if p_class_userdata.destroy != nil {
        p_class_userdata.destroy(p_instance)
    }
    TMFree(p_class_userdata, p_instance)
}

//Called by Godot
//This is the default destructor used
@(export)
bltn_Destroy :: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    if p_class_userdata.destroy != nil {
        p_class_userdata.destroy(p_instance)
    }
    gdAPI.Memory_Uils.MemFree(p_instance)
}

/*
* Examples of memory which you need to delete yourself
* The heap allocated aspects of the class (dynamic arrays), along with theadditional nodes, canvasItems, area2d that you created.
* Similar to how bulletshower needs to do cleanup on the textures and phys objects.
* Removing from scene tree does not necessarily destroy a Node.
*/

//******************************\\
//*******VIRTUAL METHODS********\\
//******************************\\

/*
* Generate a procedure unique to your class which will return the virtuals your class uses.
* Godot will not know what virtuals are configured for your class until/unless you provide it to Godot.
* This method will fetch the pointers based on the vTable you used. See virtual_method_SN.odin for the vTable Struct types.
* You do not need to interact with this beyond the inclusion of it in the registerer procedure.
*/
make_get_virtual_func :: proc(vTable: $T)-> GDE.ClassGetVirtual2 where sics.type_is_pointer(T) != true {

    args::sics.type_has_field( sics.type_base_type(T), "vCanvasItem")
    fmt.println(args)
    intermediate:=  proc "c" (p_class_userdata: ^Class_Deets, p_name: ^StringName, p_hash: u32) -> (GDE.ClassCallVirtual) {
        context = runtime.default_context()
        arg:= cast(^T)p_class_userdata.vtable
        //Will exit early if there is a match on the value.
        ok:bool=false
        virtual:rawptr=nil
        when sics.type_is_specialization_of(T, Node_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vNode") {
            virtual, ok = Return_Node_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        when sics.type_is_specialization_of(T, CanvasItem_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vCanvasItem") {
            virtual, ok = Return_CanvasItem_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        when sics.type_is_specialization_of(T, CollisionObject2D_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vCollisionObject2D") {
            virtual, ok = GDW.Return_Collision2D_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        when sics.type_is_specialization_of(T, Texture2D_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vTexture") {
            virtual, ok = GDW.Return_texture_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        return cast(GDE.ClassCallVirtual)virtual
    }
    return cast(GDE.ClassGetVirtual2)intermediate
}

@(export)
get_virtual::  proc "c" (p_class_userdata: ^Class_Deets, p_name: ^StringName, p_hash: u32) -> (GDE.ClassCallVirtual) {
    context = runtime.default_context()
    if p_class_userdata.vtable.table == nil {
        return nil
    }

    when builtin.ODIN_DEBUG {
        if p_class_userdata.vtable.table != nil {
            assert(p_class_userdata.vtable.table_type != .None)
        }
        if p_class_userdata.vtable.table_type != nil {
            assert(p_class_userdata.vtable.table != nil)
        }
    }

    ok:bool=false
    virtual:rawptr=nil
    switch p_class_userdata.vtable.table_type{
        case .None:
        case .Node:
            arg:= cast(^Node_v_table(CC_Dummy))p_class_userdata.vtable.table
            virtual, ok = Return_Node_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        case .CanvasItem:
            arg:= cast(^vCanvasItem(CC_Dummy))p_class_userdata.vtable.table
            virtual, ok = Return_Node_Virtuals(arg.vNode, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
            virtual, ok = Return_CanvasItem_Virtuals(arg.vCanvasItem, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        case .CollisionObject2D:
            arg:= cast(^vCollisionObject2D(CC_Dummy))p_class_userdata.vtable.table
            virtual, ok = Return_Node_Virtuals(arg.vNode, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
            virtual, ok = Return_CanvasItem_Virtuals(arg.vCanvasItem, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
            virtual, ok = Return_Collision2D_Virtuals(arg.vCollisionObject2D, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        case .Texture2D:
            arg:= cast(^vTexture2D(CC_Dummy))p_class_userdata.vtable.table
            virtual, ok = Return_Node_Virtuals(arg.vNode, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
            virtual, ok = Return_CanvasItem_Virtuals(arg.vCanvasItem, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
            virtual, ok = Return_texture_Virtuals(arg.vTexture, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        case:
            assert(false, "Virtual table does not match list available.")
    }
    return cast(GDE.ClassCallVirtual)virtual
}

Register :: proc(self: ^Class_Deets, init_level: InitializationLevel= .INITIALIZATION_SCENE, \
    class_info: GDE.ClassCreationInfo4 = class_info_Default) {
    
    assert(self != nil, "Register procedure received a nil value for deets. This should never happen.")
    // If this check fails, then you did not put the registration call in the correct init level of the extensionInit proc.
    assert(self.required.init_level == init_level, fmt.aprintf("Class %s init function called at a different level than was expected.", self.required.name))


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
    class_info.class_userdata = self

    when builtin.ODIN_DEBUG {
        if self.vtable.table != nil {
            assert(self.vtable.table_type != .None, "Failed to set type of the vTable.")
        }
        if self.vtable.table_type != nil {
            assert(self.vtable.table != nil, "Failed to provide vTable despite specifying type.")
        }
    }

    if (self.vtable.table != nil) {
        class_info.get_virtual_func = cast(GDE.ClassGetVirtual2)get_virtual
    }
    

    //Matching the name to the class struct is vital as it will be used in most binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct(&self.SN, self.required.name)
    self.GDClass_StringName = GDW.GDClass_StringName_get(self.required.GDClass_Index)
    gdAPI.ClassDB.RegisterExtensionClass5(GDW.Library, &self.SN, self.GDClass_StringName, &class_info)

    if self.Exporter != nil {
        self.Exporter(&self.SN)
    }
}

/*
* default for class_info would be just to expose it.
* read definition of GDE.ClassCreationInfo4 for more details on each field.
*/
@(rodata)
class_info_Default: GDE.ClassCreationInfo4 = {
    is_virtual = false,
    is_abstract = false,
    is_exposed = true,
    is_runtime = false,
}