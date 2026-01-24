package GDWrapper

import "base:runtime"
import GDE "gdextension"
import sics "base:intrinsics"
import "core:slice"
import "core:reflect"
import "core:fmt"
import "core:mem"
import "core:bytes"

/*
* Container type for the class Node.
* Self: pointer to the Godot Class as instantiated by Create.
* Will be used in Create and Destroy to allocate size and add pointer to the Godot base Node which gets created (aka Node2D)
* Will be passed into the procedures you create, as well as the virtuals that come with the Godot Node.
*/
Class_Container :: struct ($Class_Structure: typeid) {
    self: GDE.Object, //Keep as first so it can be trivially cast.
    using class: Class_Structure,
}


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
GDW_class_deets :: struct {
    using registerer: Registerer, //Keep as first value in order to trivially cast it.
    create: proc "c" (p_class_user_data: ^GDW_class_deets, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr,
    destroy: proc "c" (p_class_userdata: ^GDW_class_deets, p_instance: GDE.ClassInstancePtr),
    class_struct: typeid,
    init_level: GDE.InitializationLevel,
    GDClass_Index: ClassName_Index,
    vtable: rawptr,
    GDClass_StringName: ^GDE.StringName,
    SN : GDE.StringName,
    binder: proc "c"(),
}

/*
* Contains the registering procedure. Allows customization of procedures used for create, destroy, make_get_virtual_func
* see example_self_reggy.
* This implementation of registerer allows for the shorthand class_deets->self_register(init_level)
*/
Registerer:: struct{
    self_register: proc(self: ^Registerer, init_level: GDE.InitializationLevel),
}

/*
* A self referencing procedure to call the Register procedure.
* self: pointer to the registerer field of the GDW_class_deets for this class. Should be a pointer to itself.
* init_level: The current level of Godot's initialization. Should be passed in based on the value from your entry procedure. See extensionInit
*/
example_self_reggy:: proc(self: ^Registerer, init_level: GDE.InitializationLevel) {
    me:=(^GDW_class_deets)(self)
    Register(me, init_level)// make_get_virtual_func(THIS_CLASS_NAME_VTable)) //make_get_virtual_func will likely be needed as most classes will have virtual proc calls.
}


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
Create :: proc "c" (p_class_user_data: ^GDW_class_deets, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {

    context = runtime.default_context()

    object: GDE.ObjectPtr = gdAPI.classDBConstructObj(p_class_user_data.GDClass_StringName)

    //Create our containing struct.
    //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
    self: = cast(GDE.ObjectPtr)gdAPI.mem_alloc(size_of(p_class_user_data.class_struct) + size_of(GDE.ObjectPtr))
    mem.set(self, 0, size_of(p_class_user_data.class_struct) + size_of(GDE.ObjectPtr))
    self.proxy= object

    gdAPI.object_set_instance(object, &p_class_user_data.SN, cast(^GDE.Object)self)
    gdAPI.object_set_instance_binding(object, Library, self, &classBindingCallbacks)
    

    return object
}

/*
* This is a simple callback which Godot will call in order to free memory of you class Node.
* If you have a more complicated implementation you should either wrap this in your own call or replace it completely.
* This procedure is associated with your class via the class_info struct built-up in the Register procedure.
*/
Destroy :: proc "c" (p_class_userdata: ^GDW_class_deets, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    gdAPI.mem_free(p_instance)
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

      intermediate:=  proc "c" (p_class_userdata: ^GDW_class_deets, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> (virtual: GDE.ClassCallVirtual) {
          context = runtime.default_context()
          arg:= cast(^T)p_class_userdata.vtable

          when sics.type_is_subtype_of(sics.type_elem_type(T), Node_v_table){
              virtual = cast(GDE.ClassCallVirtual)Return_Node_Virtuals(arg^, nil, p_name, p_hash)
              if virtual != nil do return virtual
          }
          when sics.type_is_subtype_of(sics.type_elem_type(T), CanvasItem_v_table){
              virtual = cast(GDE.ClassCallVirtual)Return_Draw_Virtuals(arg^, nil, p_name, p_hash)
              if virtual != nil do return virtual
          }
          when sics.type_is_subtype_of(sics.type_elem_type(T), CollisionObject2D_v_table){
              virtual = cast(GDE.ClassCallVirtual)Return_Collision2D_Virtuals(arg^, nil, p_name, p_hash)
              if virtual != nil do return virtual
          }
          when sics.type_is_subtype_of(sics.type_elem_type(T), Texture2D_v_table){
              virtual = cast(GDE.ClassCallVirtual)Return_texture_Virtuals(arg^, nil, p_name, p_hash)
              if virtual != nil do return virtual
          }
  
  
          return virtual
      }
    return cast(GDE.ClassGetVirtual2)intermediate
}

Register :: proc(self: ^GDW_class_deets, init_level: GDE.InitializationLevel, get_v_table: GDE.ClassGetVirtual2 = nil, \
    create: proc "c" (p_class_user_data: ^GDW_class_deets, p_notify_postinitialize: GDE.Bool) -> (GDE.ObjectPtr) = Create, \
    destroy: proc "c" (p_class_userdata: ^GDW_class_deets, p_instance: GDE.ClassInstancePtr) = Destroy, \
    class_info: GDE.ClassCreationInfo4 = class_info_Default) {
    
    // If this check fails, then you did not put the registration call in the correct init level of the extensionInit proc.
    assert(self.init_level == init_level, fmt.aprintf("Class %s init function called at a different level than was expected.", type_info_of(self.class_struct).variant.(runtime.Type_Info_Named).name))

    //Set the create and destroy procs in the class's deets struct for easy reference in Odin-land.
    self.create = create
    self.destroy = destroy

    //string to a svg which will be used as an icon for your Nodes.
    //Must be NewLatin. UTF8 does not work :/
    stringraw:GDE.gdstring
    StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    //review definition of GDE.ClassCreationInfo4 for more details on each field.
    
    class_info: GDE.ClassCreationInfo4 = class_info
        class_info.icon_path = &stringraw
        class_info.create_instance_func = cast(proc "c" (p_class_userdata: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr)create
        class_info.free_instance_func = cast(proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr))destroy
        class_info.class_userdata = self
        class_info.get_virtual_func = get_v_table

    //Matching the name to the class struct is vital as it will be used in most binding helpers. If the name doesn't match things will break.
    StringConstruct.stringNameNewString(&self.SN, type_info_of(self.class_struct).variant.(runtime.Type_Info_Named).name)

    self.GDClass_StringName = GDClass_StringName_get(self.GDClass_Index)

    gdAPI.classDBRegisterExtClass(Library, &self.SN, self.GDClass_StringName, &class_info)
    
    if self.binder != nil {
        self.binder()
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