//Godot C guide : https://docs.godotengine.org/en/latest/tutorials/scripting/gdextension/gdextension_c_example.html
//Godo cmd options : https://docs.godotengine.org/en/latest/tutorials/editor/command_line_tutorial.html
//launch scene directly with godot [path to scene] --Path [path to godot project file]
//Currently the build script just launches the editor via the location of my project.godot file.
//Community built Godot Bindings (Includes generator) : https://github.com/dresswithpockets/odin-godot
//TODO: build from source to be able to debug the engine errors. Currently they tell me NOTHING and their functions provide no error return. Madness.
//Debugger setup instructions? Requires building from source : https://www.reddit.com/r/godot/comments/11d56t1/gdextension_how_to_get_debugger_working_when/
//https://godotforums.org/d/32073-debug-c-gdextension/16

package main

import "base:runtime"
import "core:fmt"
import str "core:strings"
import "core:slice"
import strc "core:strconv"
import GDE "GDWrapper/gdextension"
import "core:math/linalg"
import GDW "GDWrapper"



icon:= "res://icon.svg"



/******************************/
/**********INITIALIZATION******/
/******************************/

//ENTRY POINT: This name needs to match the name in the gdexample.gdextension file.
//If the name does not match, Godot will not know where/how to bind to function.
@export
gdexample_library_init :: proc "contextless" (p_get_proc_address : GDE.InterfaceGetProcAddress, p_library: GDE.GDExtensionClassLibraryPtr, r_initialization: ^GDE.GDExtensionInitialization) -> b8 {
    context = runtime.default_context()
    GDW.class_library = p_library
    GDW.loadAPI(p_get_proc_address)
    fmt.println("1")


    /* This function will be called multiple times for each initialization level. */
    r_initialization.initialize   = initialize_gdexample_module
    r_initialization.deinitialize = deinitialize_gdexample_module
    r_initialization.userdata     = nil
    r_initialization.minimum_initialization_level = .INITIALIZATION_SCENE


    return true
}

//TODO: figure out if you can create multiple classes from a single init module.
initialize_gdexample_module :: proc "c" (p_userdata: rawptr, p_level:  GDE.InitializationLevel){

    if p_level != .INITIALIZATION_SCENE{
        return
    }
    
    context = runtime.default_context()

    fmt.println("AAAAAAAAAaaaaaaahhhh")

    
    // Get ClassDB methods here because the classes we need are all properly registered now.
    // See extension_api.json for hashes.
    native_class_name: GDE.StringName;
    method_name: GDE.StringName;

    //GDW.constructor.stringNameNewWithLatinChars(&native_class_name, "Node2D", false);
    //GDW.constructor.stringNameNewWithLatinChars(&method_name, "set_position", false);
    //GDW.methods.node2dSetPosition = GDW.api.classDBGetMethodBind(&native_class_name, &method_name, 743155724);
    
    //fmt.println(GDW.methods.node2dSetPosition)
    //GDW.destructors.stringNameDestructor(&native_class_name);
    //GDW.destructors.stringNameDestructor(&method_name);
    
    //GDW.constructor.stringNameNewWithLatinChars(&native_class_name, "Object", false)
    //GDW.constructor.stringNameNewWithLatinChars(&method_name, "emit_signal", false)
    //
    //GDW.methods.objectEmitSignal = GDW.api.classDBGetMethodBind(&native_class_name, &method_name, 4047867050)
    //
    //GDW.destructors.stringNameDestructor(&native_class_name)
    //GDW.destructors.stringNameDestructor(&method_name)

    
    //GDW.constructor.stringNameNewWithLatinChars(&native_class_name, "Node2D", false)
    //GDW.constructor.stringNameNewWithLatinChars(&method_name, "get_position", false)
    
    //GDW.methods.node2dGetPos = GDW.api.classDBGetMethodBind(&native_class_name, &method_name, 3341600327)
    
    //GDW.destructors.stringNameDestructor(&native_class_name)
    //GDW.destructors.stringNameDestructor(&method_name)

    GDW.methods.objectEmitSignal = GDW.classDBGetMethodBind("Object", "emit_signal", 4047867050)
    GDW.methods.node2dGetPos = GDW.classDBGetMethodBind("Node2D", "get_position", 3341600327)
    GDW.methods.node2dSetPosition = GDW.classDBGetMethodBind("Node2D", "set_position", 743155724)

    class_name: GDE.StringName
    parent_class_name: GDE.StringName
    GDW.constructor.stringNameNewWithLatinChars(&class_name, "GDExample", false)
    GDW.constructor.stringNameNewWithLatinChars(&parent_class_name, "Sprite2D", false)

    stringptr:GDE.gdstring
    fmt.println("AAAAAAAAAfter methodBind")

    
    stringraw: GDE.gdstring
    //makestring : GDE.GDExtensionInterfaceStringNewWithLatin1Chars
    //makestring = cast(GDE.GDExtensionInterfaceStringNewWithLatin1Chars)GDW.api.p_get_proc_address("string_new_with_latin1_chars")
    mystring:=str.clone_to_cstring(icon)
    //^^^^^There is a string maker that takes lenght, so might not need to be cloning these.
    
    //Does indeed create a string in some kind of memory.
    GDW.constructor.stringNewLatin(&stringraw, mystring)
    //Pointers just need to be packed data of the correct bit length. The type gdstring was declared above.
    //Though maybe Godot expects a struct format for their templates.
    //stringgd: gdstring
    //makestring(&stringgd, "res://icon.svg")
    //But odin takes care of sizing based on 32 or 64 bit, so just us rawptr.
    
    fmt.println("AAAAAAAAAfter string")
    //To get access to the string you need to cast it to another pointer type then dereference.
    //To properly handle this directly we'd need to be able to know the underlying memory setup of a C++ string.
    //fmt.println((cast(^i8)stringraw)^)

    //Will need to get more info about how these settings affect classes. Ex runtime?
    class_info: GDE.GDExtensionClassCreationInfo4 = {
        is_virtual = false,
        is_abstract = false,
        is_exposed = true,
        is_runtime = false,
        icon_path = &stringraw, //For some reason does not work with UTF8 strings??
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
    fmt.println("AAAAAAAAAaafter struct")


    //Register Class
    GDW.api.classDBRegisterExtensionClass4(GDW.class_library, &class_name, &parent_class_name, &class_info)
    fmt.println("AAAAAAAAAaaaaaaahhhh", &GDW.class_library, &class_name, &parent_class_name, &class_info)
    
    gdexample_class_bind_method()
    fmt.println("binding completed")


    //GDW.destructors.stringNameDestructor(&class_name)
    //GDW.destructors.stringNameDestructor(&parent_class_name)
    //GDW.destructors.stringDestruction(&stringraw)

}

deinitialize_gdexample_module :: proc "c" (p_userdata: rawptr, p_level: GDE.InitializationLevel){

}


gdexample_class_bind_method :: proc "c" () {
    context = runtime.default_context()
    fmt.println("bind methods")

    //You're gonna have to have this since at minimum any Editor facing variable will need both a getter and setter.
    //GDW.bindMethod0r("GDExample", "get_amplitude", ClassGetAmplitude, .FLOAT)
    
    GDW.bindMethod1("GDExample", "set_amplitude", ClassSetAmplitude, "amplitude", .FLOAT)
    GDW.bindProperty("GDExample", "amplitude", .FLOAT, "get_amplitude", "set_amplitude");

    //GDW.methodBind(ClassSetAmplitude)
    //GDW.bindMethod0r("GDExample", "get_speed", ClassGetSpeed, .FLOAT)
    //GDW.bindMethod1("GDExample", "set_speed", ClassSetSpeed, "speed", .FLOAT)
    //GDW.bindMethod1("GDExample", "set_speed", ClassSetSpeed, "speed", .FLOAT)
    
    ptrcallFunc:GDE.GDExtensionClassMethodPtrCall
    callFunc:GDE.GDExtensionClassMethodCall
    ptrcallFunc, callFunc=GDW.methodBind(ClassSetAmplitude)
    
    ptrcallFunc, callFunc = GDW.methodBind(ClassSetSpeed)
    GDW.bindProperty("GDExample", "speed", .FLOAT, "get_speed", "set_speed")

    //I provide the name of the signal and the name of the variable to make available in GDScript. (and other custom classes?)
    //GDW.bindSignal1("GDExample", "position_changed", "new_position", .VECTOR2)
}


//Create instance will always run on program launch regardless if it's in the scene or not.
//This will also run when the scene starts. Once for each instance of the Node present in the tree.
gdexampleClassCreateInstance :: proc "c" (p_class_user_data: rawptr, p_notify_postinitialize: GDE.GDExtensionBool) -> GDE.GDExtensionObjectPtr {
    context = runtime.default_context()

    fmt.println("2222222222")
    
    //create native Godot object.
    //Here we create an object that is part of Godot core library.
    class_name : GDE.StringName
    GDW.constructor.stringNameNewWithLatinChars(&class_name, "Sprite2D", false)
    object: GDE.GDExtensionObjectPtr = GDW.api.classdbConstructObject(&class_name)
    GDW.destructors.stringNameDestructor(&class_name)

    //Create extension object.
    //Can replace mem_alloc with new(). Just need to create the struct and pass a pointer.
    self: ^GDExample = cast(^GDExample)GDW.api.mem_alloc(size_of(GDExample))

    //constructor is called after creation. Sets the defaults.
    //Pretty sure the doc info about defaults uses this.
    class_constructor(self)
    self.object = object

    //Set extension instance in the native Godot object.
    GDW.constructor.stringNameNewWithLatinChars(&class_name, "GDExample", false)
    GDW.api.object_set_instance(object, &class_name, self)
    GDW.api.object_set_instance_binding(object, GDW.class_library, self, classBindingCallbacks)

    //Heap cleanup.
    GDW.destructors.stringNameDestructor(&class_name)

    return object
}

//WARNING : Free any heap memory allocated within this context.
//There's also a destructor, so what's the difference?
//Does destructor just clear the variable data and this is supposed to clear the class itself?
//Maybe it's so that destructor can be run when making editor changes like reset?
gdexampleClassFreeInstance :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.GDExtensionClassInstancePtr) {
    context = runtime.default_context()
    if (p_instance == nil){
        return
    }
    self : ^GDExample = cast(^GDExample)p_instance
    class_destructor(self)
    GDW.api.mem_free(self)
}


//This is where you would set your defaults.
//Seeing as both the create and construct are called when something is made I wonder if this is just redundency or trying to make things more C++ styled despite it not needing to be.
//Odin defaults everything to 0 regardless, so maybe not as horrible if you forget some?
//Using the reset button doesn't even call this thing.
class_constructor :: proc "c" (self: ^GDExample) {
    context = runtime.default_context()
    fmt.println("class constructor")
    self.amplitude = 10
    self.speed = 1
    self.timePassed = 0
    self.time_emit = 0
    GDW.constructor.stringNameNewWithLatinChars(&self.position_changed, "position_changed", false)
}

class_destructor  :: proc  "c" (self: ^GDExample) {
    context = runtime.default_context()

   GDW.destructors.stringNameDestructor(&self.position_changed)
}


//*************************\\
//*****Class Variables*****\\
//*************************\\

//Struct to hold node data.
//This struct should hold the class variables. (following the C guide)
GDExample :: struct{
    //public properties. Could be functions pointers?
    amplitude: f64,
    speed: f64,
    object: GDE.GDExtensionObjectPtr, //Stores the underlying Godot data. //Set in gdexampleClassCreateInstance.

    //''''''private''''''' variables.
    timePassed: f64,
    time_emit: f64,

    //Metadata
    position_changed: GDE.StringName, //Specifies the signal StringName used in class.StringName.connect(func_to_call). 
}

//****************************\\
//******Functions/Methods*****\\
//****************************\\

//Wew, OOP Getter setters. /s
//Really hope there's a way to properly expose variables to the rest of the programs
//and apparently not. exposing a property to the editor requires you to provide a getter and setter for the editor to fetch and update the value.
//The getter and setter are called every.single.tick. Don't make one that's too expensive.
ClassSetAmplitude :: proc "c" (self: ^GDExample, amplitude: f64) {
    context = runtime.default_context()
    fmt.println("amp: ", self)
    self.amplitude = amplitude
}

ClassGetAmplitude :: proc "c" (self: ^GDExample) -> f64 {
    context = runtime.default_context()

    fmt.println("amp: ", self.amplitude)
    return self.amplitude
}


ClassSetSpeed :: proc "c" (self: ^GDExample, speed: f64) {
    self.speed = speed
}
/*
ClassGetSpeed :: proc "c" (self: ^GDExample) -> f64 {
    context = runtime.default_context()

    fmt.println("speed: ", self.speed)
    return self.speed
}
*/


//*****************************\\
//************Godot************\\
//******Virtual Functions******\\

classProcess :: proc "c" (self: ^GDExample, delta: f64) {
    context = runtime.default_context()
    //fmt.println("Delta time: ",delta)
    self.timePassed += self.speed * f64(delta)
    newPosition: GDE.Vector2

    //methods.node2dGetPos()

    //This is the original code. Relies on godot in several spots,which means making multiple multipointer slices.
    //Ultimately you can do the same yourself since Odin has nice vector stuff.
    //Only tricky thing is to use the correct float type. Godot's function seemingly converts to the correct float typeID even if you pass f64.
    //vec2::[2]f64
    //myVec:vec2
    //origVec: [2]f64
    //
    //// Set up the arguments for the Vector2 constructor.
    //x: f64 = self.amplitude + (self.amplitude * linalg.sin(self.timePassed * 2.0));
    //y: f64 = self.amplitude + (self.amplitude * linalg.cos(self.timePassed * 1.5));
    //vect2: = [?]rawptr {&x, &y}
    //args: GDE.GDExtensionConstTypePtrargs 
    //args = raw_data(rawptr(vect2[:]))
    //OR
    //args = cast([^]rawptr)(raw_data(myVec[:]))
    //// Call Godot's Vector2 constructor.
    //fmt.println("build vector")
    ////constructor.vector2ConstructorXY(&newPosition, args);


    //gdvector2 is a struct of an array
    //I need to create a multipointer array containing this struct
    //All I need to do is declare the newposition variable, input the data into it
    //add that gdvector2 to a new array which itself is the multipointer array that Godot will take args from.
    //COULD make a helper function to convert the types according to Godot. That way I keep double precision on my side without doing a ton of type casting manually.
    vec2::[2]f32
    myVec:vec2
    
    // Set up the arguments for the Vector2 constructor.
    myVec.x = f32(self.amplitude + (self.amplitude * linalg.sin(self.timePassed * 2.0)))
    myVec.y = f32(self.amplitude + (self.amplitude * linalg.cos(self.timePassed * 1.5)))
    //All the things below are equivalent ways to cast and copy the same things.
    //vect2: = [?]rawptr {&x, &y}
    //args: GDE.GDExtensionConstTypePtrargs 
    //args = raw_data(rawptr(vect2[:]))
    //args = cast(GDE.GDExtensionConstTypePtrargs)(raw_data(myVec[:]))
    //copy(myVec[:], (cast([^]f64)args)[:2])
    //myVec.x = (cast(^f64)((args[:2])[0]))^
    // Call the Vector2 constructor.
    //constructor.vector2ConstructorXY(&newPosition, raw_data(vect2[:]));
    //constructor.vector2ConstructorXY(&newPosition, args);
    newPosition.data=myVec

    // Set up the arguments for the set_position method.
    args2 :=[?]rawptr{&newPosition}

    
    // Call the set_position method.
    GDW.api.objectMethodBindPtrCall(GDW.methods.node2dSetPosition, self.object, raw_data(args2[:]), nil);


    //Calls the get_position method.
    variant: GDE.Variant
    args: GDE.GDExtensionConstVariantPtrargs //dummy value
    GDW.api.objectMethodBindCall(GDW.methods.node2dGetPos, self.object, args, 0, &variant, nil)
    gotvec2: vec2
    GDW.constructor.variantToVec2Constructor(&gotvec2, &variant)
    //fmt.println(gotvec2)

    //gotvec2 and gotvec3 should be the same.
    gotvec3: vec2
    
    GDW.api.objectMethodBindPtrCall(GDW.methods.node2dGetPos, self.object, nil, cast(rawptr)(&gotvec3))

    //fmt.println(gotvec3)

    //GDW.methodBind(testWhere)
    //GDW.methodBind(testproc)
    
    //GDW.bindNoReturn(32)
    //GDW.bindingfunc()

    //Handle when to send a signal to Godot.
    self.time_emit += f64(delta)
    if self.time_emit >= 1 {
        //call emit signal function
        GDW.call_2_args_stringname_vector2_no_ret_variant(GDW.methods.objectEmitSignal, self.object, &self.position_changed, &newPosition)
        self.time_emit = 0
    }
}



//*****************************\\
//*******Godot Callbacks*******\\
//*****************************\\
/*
*Godot will call this function to ask if there's any of its virtual functions that it should override(?) with our own.
*Will make a call for each virtual associated with the class our objectClass is associated/inheriting from.
*/
getVirtualWithData :: proc "c" (p_class_userdata: rawptr, p_name: GDE.GDExtensionConstStringNamePtr, p_hash: u32) -> rawptr {
    context = runtime.default_context()

    //Can just use Odin's array compare. I do this in another section.
    if GDW.isStringNameEqual(p_name, "_process") {
        fmt.println("process pointer got")
        return cast(rawptr)classProcess
    }

    return nil
}

/*
* This is Godot telling us to use the function. So we need to call it.
* It doesn't give and argument count so we need to know it ahead of time?
*/
callVirtualFunctionWithData :: proc "c" (p_instance: rawptr, p_name: GDE.GDExtensionConstStringNamePtr, p_virtualProcPtr: rawptr, p_args: GDE.GDExtensionConstTypePtrargs, r_ret: GDE.GDExtensionTypePtr) {
    context = runtime.default_context()
    //fmt.println("p_virtualProcPtr: ", p_virtualProcPtr)
    fmt.println("classProcess: ", classProcess)


    //Godot provides the exact pointer that we passed in getVirtualWithData for the function on our side.
    if p_virtualProcPtr == cast(rawptr)classProcess {
        //fmt.println("process called.")
        GDW.ptrcall_1_float_arg_no_ret(p_virtualProcPtr, p_instance, p_args, r_ret)
    }
}

//Need to setup a way to provide pointers to the above.
//Wrappers for specific proc calls added to API.


classBindingCallbacks: GDE.GDExtensionInstanceBindingCallbacks = {
    create_callback    = nil,
    free_callback      = nil,
    reference_callback = nil
}


testproc :: proc(classptr: ^GDExample, arg0: int) {
    //testproc
}

testWhere :: proc() {

}