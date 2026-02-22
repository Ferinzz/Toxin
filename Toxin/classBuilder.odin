package Toxin

import "base:runtime"
import GDE "shared:GDWrapper/gdAPI/gdextension"
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import sics "base:intrinsics"
import "core:fmt"
import "core:mem"
import "core:reflect"

/*
* Container type for the class Node.
* Self: pointer to the Godot Class as instantiated by Create.
* Will be used in Create and Destroy to allocate size and add pointer to the Godot base Node which gets created (aka Node2D)
* Will be passed into the procedures you create, as well as the virtuals that come with the Godot Node.
*/
Class_Container :: GDW.Class_Container
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
    using registerer: Registerer, //Keep as first value in order to trivially cast it.
    create: proc "c" (p_class_user_data: ^Class_Deets, p_notify_postinitialize: GDW.Bool) -> (^GDW.Object), //Cast to the Object class that your class extends.
    destroy: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr),
    class_struct: typeid,
    init_level: InitializationLevel,
    GDClass_Index: GDW.ClassName_Index,
    vtable: rawptr,
    GDClass_StringName: ^StringName,
    SN : StringName,
    binder: proc(className: ^StringName),
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
Registerer:: struct{
    self_register: proc(self: ^Registerer, init_level: InitializationLevel),
}

/*
* A self referencing procedure to call the Register procedure.
* self: pointer to the registerer field of the Class_Deets for this class. Should be a pointer to itself.
* init_level: The current level of Godot's initialization. Should be passed in based on the value from your entry procedure. See extensionInit
*/
example_self_reggy:: proc(self: ^Registerer, init_level: InitializationLevel) {
    me:=(^Class_Deets)(self)
    Register(me, init_level)// make_get_virtual_func(THIS_CLASS_NAME_VTable)) //make_get_virtual_func will likely be needed as most classes will have virtual proc calls.
}

//Implementation details. For a simple implementation you should only need to use the above structs and call the self referenced register proc.

/*
* TODO: not implemented.
*/
reg_list: struct {
    count: int,
    deets: [5]^Registerer,
}

//I still don't know what these are for :/
classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil,
};

//This runs once when the class is created before it gets added to a tree.
//construct parent class, malloc your class struct, set defaults, heap allocate variables, construct any class children.
//This is different from Godot's ready, which is called sometime after this.
//Returns a pointer to Class_Container(your_class_struct)
Create :: proc(p_class_user_data: ^Class_Deets, p_notify_postinitialize: GDW.Bool) -> (^GDW.Class_Container(GDW.CC_Dummy)) {
    //context = runtime.default_context()

    object: ^GDW.Object = gdAPI.ClassDB.ConstructObject(p_class_user_data.GDClass_StringName)

    //Create our containing struct.
    //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
    self: = cast(^GDW.Class_Container(GDW.CC_Dummy))gdAPI.Memory_Uils.MemAlloc(reflect.size_of_typeid(p_class_user_data.class_struct) + size_of(^GDW.Object))
    mem.set(self, 0, reflect.size_of_typeid(p_class_user_data.class_struct) + size_of(^GDW.Object))
    //mem.set(self, 0, size_of(p_class_user_data.class_struct) + size_of(^GDW.Object))
    self.self= object

    gdAPI.Object_Utils.SetInstance(object, &p_class_user_data.SN, cast(^GDW.Object)self)
    gdAPI.Object_Utils.SetInstanceBinding(object, GDW.Library, self, &classBindingCallbacks)


    return self
}
Class_Init::proc "c" (p_class_user_data: ^Class_Deets, p_notify_postinitialize: GDW.Bool) -> (^GDW.Object) {
    context = runtime.default_context()
    class:= Create(p_class_user_data, p_notify_postinitialize)
    return class.self
}

/*
* This is a simple callback which Godot will call in order to free memory of you class Node.
* If you have a more complicated implementation you should either wrap this in your own call or replace it completely.
* This procedure is associated with your class via the class_info struct built-up in the Register procedure.
* GDE.ClassInstancePtr is a pointer to a Class_Container(T:typeid)
*/
Destroy :: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
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
        when sics.type_is_subtype_of(sics.type_elem_type(T), Node_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vNode"){
            virtual, ok = Return_Node_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        when sics.type_is_subtype_of(sics.type_elem_type(T), CanvasItem_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vCanvasItem"){
            virtual, ok = Return_Draw_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        when sics.type_is_subtype_of(sics.type_elem_type(T), CollisionObject2D_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vCollisionObject2D"){
            virtual, ok = GDW.Return_Collision2D_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        when sics.type_is_subtype_of(sics.type_elem_type(T), Texture2D_v_table) || 
        sics.type_has_field( sics.type_base_type(T), "vTexture"){
            virtual, ok = GDW.Return_texture_Virtuals(arg^, nil, p_name, p_hash)
            if virtual != nil || ok do return cast(GDE.ClassCallVirtual)virtual
        }
        return cast(GDE.ClassCallVirtual)virtual
    }
    return cast(GDE.ClassGetVirtual2)intermediate
}

Register :: proc(self: ^Class_Deets, init_level: InitializationLevel, get_v_table: GDE.ClassGetVirtual2 = nil, \
    create: proc "c" (p_class_user_data: ^Class_Deets, p_notify_postinitialize: GDW.Bool) -> (^GDW.Object) = Class_Init, \
    destroy: proc "c" (p_class_userdata: ^Class_Deets, p_instance: GDE.ClassInstancePtr) = Destroy, \
    class_info: GDE.ClassCreationInfo4 = class_info_Default) {
    
    // If this check fails, then you did not put the registration call in the correct init level of the extensionInit proc.
    assert(self.init_level == init_level, fmt.aprintf("Class %s init function called at a different level than was expected.", type_info_of(self.class_struct).variant.(runtime.Type_Info_Named).name))

    //Set the create and destroy procs in the class's deets struct for easy reference in Odin-land.
    self.create = create
    self.destroy = destroy

    //string to a svg which will be used as an icon for your Nodes.
    //Must be NewLatin. UTF8 does not work :/
    stringraw:GDW.gdstring
    gdAPI.Strings_Utils.NewWithLatin1Chars(&stringraw, "res://icon.svg")

    //review definition of GDE.ClassCreationInfo4 for more details on each field.
    
    class_info: GDE.ClassCreationInfo4 = class_info
        class_info.icon_path = &stringraw
        class_info.create_instance_func = cast(proc "c" (p_class_userdata: rawptr, p_notify_postinitialize: GDW.Bool) -> ^GDW.Object)create
        class_info.free_instance_func = cast(proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr))destroy
        class_info.class_userdata = self
        class_info.get_virtual_func = get_v_table

    //Matching the name to the class struct is vital as it will be used in most binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct(&self.SN, type_info_of(self.class_struct).variant.(runtime.Type_Info_Named).name)

    self.GDClass_StringName = GDW.GDClass_StringName_get(self.GDClass_Index)

    gdAPI.ClassDB.RegisterExtensionClass5(GDW.Library, &self.SN, self.GDClass_StringName, &class_info)
    
    if self.binder != nil {
        self.binder(&self.SN)
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