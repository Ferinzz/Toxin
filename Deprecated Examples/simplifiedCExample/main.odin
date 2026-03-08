package main

import "core:fmt"
import sics "base:intrinsics"
import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import str "core:strings"
import s "core:slice"
import "core:unicode/utf8"
import "core:math/linalg"

@export
godot_entry_init :: proc "c" (p_get_proc_address : GDE.InterfaceGetProcAddress, p_library: GDE.ClassLibraryPtr, r_initialization: ^GDE.Initialization) {
    context = runtime.default_context()
    
    GDW.Library = p_library
    GDW.loadAPI(p_get_proc_address)

    r_initialization.initialize     = initialize_gdexample_module
    r_initialization.deinitialize   = deinitialize_gdexample_module
    r_initialization.userdata     = nil
    r_initialization.minimum_initialization_level = .INITIALIZATION_SCENE

}


//*************************\\
//*****Class Variables*****\\
//*************************\\

//Struct to hold node data.
//This struct should hold the class variables. (following the C guide)
GDExample :: struct {
    //REQUIRED
    object: GDE.ObjectPtr,

    //others
    timePassed: f64,
    amplitude: f64,
    speed: f64,
    time_emit: f64,

    //Metadata
    position_changed: GDE.StringName, //Specifies the signal StringName
}

//****************************\\
//******Functions/Methods*****\\
//****************************\\

//required fields. 
//classname
//parentname
//creationinfo4 - I feel like this should be defined by the user. Not going to be able to assume much.
//Create instance and Free instance should be written by the user. Can't assume how they want to handle the memory.
//Can we create an allocator dynamically? Allow for us to free all at once when the instance needs to be culled.
initialize_gdexample_module :: proc "c" (p_userdata: rawptr, p_level:  GDE.InitializationLevel){

    if p_level != .INITIALIZATION_SCENE{
        return
    }
    
    context = runtime.default_context()

    fmt.println("AAAAAAAAAaaaaaaahhhh")

    
    // Get ClassDB Methods here because the classes we need are all properly registered now.
    // See extension_api.json for hashes.
    native_class_name: GDE.StringName;
    method_name: GDE.StringName;

    GDW.Methods.node2dGetPos = GDW.classDBGetMethodBind("Node2D", "get_position", 3341600327)
    GDW.Methods.node2dSetPosition = GDW.classDBGetMethodBind("Node2D", "set_position", 743155724)

    class_name: GDE.StringName
    parent_class_name: GDE.StringName
    //Name for my own class.
    //fmt.println("AAAAAAAAAaaaaaaahhhh")
    GDW.StringConstruct.stringNameNewLatin(&class_name, "GDExample", false)
    //fmt.println("AAAAAAAAAaaaaaaahhhh")
    //Name of the class that I'm inheritting from.
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, "Sprite2D", false)

    stringptr:GDE.gdstring
    //fmt.println("AAAAAAAAAfter methodBind")

    

    
    iconString: GDE.gdstring
    icon:= "res://icon.svg"
    mystring:=str.clone_to_cstring(icon)
    defer(delete(mystring))
    //^^^^^There is a string maker that takes length, so might not need to be cloning these.
    
    //Does indeed create a string in some kind of memory.
    GDW.StringConstruct.stringNewLatin(&iconString, mystring)

    //Will need to get more info about how these settings affect classes. Ex runtime?
    class_info: GDE.ClassCreationInfo4 = {
        is_virtual = false,
        is_abstract = false,
        is_exposed = true,
        is_runtime = false,
        icon_path = &iconString, //For some reason does not work with UTF8 strings??
        set_func = nil,
        get_func = nil,
        get_property_list_func = nil,
        free_property_list_func = nil,
        property_can_revert_func = nil,
        property_get_revert_func = nil,
        validate_property_func = nil,
        notification_func = nil,
        to_string_func = nil,
        reference_func = nil,
        unreference_func = nil,
        create_instance_func = gdexampleClassCreateInstance,
        free_instance_func = gdexampleClassFreeInstance,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func = getVirtualWithData,
        call_virtual_with_data_func = callVirtualFunctionWithData,
        class_userdata = nil, 
    }
    //fmt.println("AAAAAAAAAaafter struct")


    //Register Class
    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &class_name, &parent_class_name, &class_info)
    //fmt.println("AAAAAAAAAaaaaaaahhhh", &GDW.Library, &class_name, &parent_class_name, &class_info)
    
    gdexample_class_bind_method()
    //fmt.println("binding completed")


    GDW.Destructors.stringNameDestructor(&class_name)
    GDW.Destructors.stringNameDestructor(&parent_class_name)
    GDW.Destructors.stringDestruction(&iconString)

}

deinitialize_gdexample_module :: proc "c" (p_userdata: rawptr, p_level: GDE.InitializationLevel){

}


gdexample_class_bind_method :: proc "c" () {
    context = runtime.default_context()
    //fmt.println("bind Methods")

    GDW.makePublic(GDExample, "speed")
    GDW.makePublic(GDExample, "amplitude")
    GDW.registerSignal("GDExample", "position_changed", {.FLOAT}, {"new_pos"}, 1)
    
}



//Create instance will always run on program launch regardless if it's in the scene or not.
//This will also run when the scene starts. Once for each instance of the Node present in the tree.
gdexampleClassCreateInstance :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
    context = runtime.default_context()

    //fmt.println("2222222222")
    
    //create native Godot object.
    //Here we create an object that is part of Godot core library.
    class_name : GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&class_name, "Sprite2D", false)
    object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)
    GDW.Destructors.stringNameDestructor(&class_name)

    //Create extension object.
    //Use mem_alloc to allocate in Godot memory or Odin's new to allocate in the library memory.
    //Deallocation should be owned depending on which you use. aka if it's possible that Godot will deallocate, do it with mem_alloc.
    self: ^GDExample = cast(^GDExample)GDW.gdAPI.mem_alloc(size_of(GDExample))

    //constructor is called after creation. Sets the defaults.
    //Pretty sure the doc info about defaults uses this.
    class_constructor(self)
    self.object = object

    //Set extension instance in the native Godot object.
    GDW.StringConstruct.stringNameNewLatin(&class_name, "GDExample", false)
    GDW.gdAPI.object_set_instance(object, &class_name, self)
    GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

    //Heap cleanup.
    GDW.Destructors.stringNameDestructor(&class_name)

    //uninitptr: GDE.Variant

    return object
}

classBindingCallbacks: GDE.InstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}


//WARNING : Free any heap memory allocated by your class within this context.

gdexampleClassFreeInstance :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    self : ^GDExample = cast(^GDExample)p_instance
    class_destructor(self)
    GDW.gdAPI.mem_free(self)
}


//This is where you would set your defaults.
class_constructor :: proc "c" (self: ^GDExample) {
    context = runtime.default_context()
    
    self.timePassed = 0

    self.amplitude = 30    
    self.speed = 10
    self.time_emit = 0
    GDW.StringConstruct.stringNameNewLatin(&self.position_changed, "position_changed", false)
}

class_destructor  :: proc  "c" (self: ^GDExample) {
    context = runtime.default_context()

   GDW.Destructors.stringNameDestructor(&self.position_changed)
}




//*****************************\\
//************Godot************\\
//******Virtual Functions******\\

classProcess :: proc "c" (self: ^GDExample, delta: f64) {
    context = runtime.default_context()
    delta:=delta
    
    self.timePassed += self.speed * f64(delta)
    newPosition: GDE.Vector2
    //Handle when to send a signal to Godot.
    vec2::[2]f32
    myVec: GDE.Vector2//vec2
    
    // Set up the arguments for the Vector2 constructor.
    myVec.x = f32(self.amplitude + (self.amplitude * linalg.sin(self.timePassed * 2.0)))
    myVec.y = f32(self.amplitude + (self.amplitude * linalg.cos(self.timePassed * 1.5)))

    
    newPosition=GDE.Vector2(myVec)

    // Set up the arguments for the set_position method.
    args2 :=[?]rawptr{&newPosition}

    
    // Call the set_position method.
    GDW.gdAPI.objectMethodBindPtrCall(GDW.Methods.node2dSetPosition, self.object, raw_data(args2[:]), nil);

    self.time_emit += f64(delta)
    if self.time_emit >= 1 {
        //call emit signal function
        GDW.emitSignal(self.object, &self.position_changed, &delta)
        self.time_emit = 0
    }
}



//*****************************\\
//*******Godot Callbacks*******\\
//*****************************\\
//Not going to be able to sort these out at compile time. User is going to have to write these out by hand.
//It is what it is.
//A more dynamically typed language might be able to do it, since the limiting factor is that procs are unique types.


/*
*Godot will call this function to ask if there's any of its virtual functions that it should override(?) with our own.
*Will make a call for each virtual associated with the class our objectClass is associated/inheriting from.
*/
getVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.ConstStringNamePtr, p_hash: u32) -> rawptr {
    context = runtime.default_context()

    if GDW.stringNameCompare(p_name, "_process"){
        return cast(rawptr)classProcess
    }

    return nil
}

/*
* This is Godot telling us to use the function. So we need to call it.
* It doesn't give and argument count so we need to know it ahead of time?
*/
callVirtualFunctionWithData :: proc "c" (p_instance: rawptr, p_name: GDE.ConstStringNamePtr, p_virtualProcPtr: rawptr, p_args: GDE.ConstTypePtrargs, r_ret: GDE.TypePtr) {
    context = runtime.default_context()

    //Godot provides the exact pointer that we passed in getVirtualWithData for the function on our side.
    if p_virtualProcPtr == cast(rawptr)classProcess {
        GDW.virtualProcCall(classProcess, p_instance, p_args, r_ret)
    }
}