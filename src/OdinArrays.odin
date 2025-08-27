package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"

//Find and Replace OdinArrays with the name that you will be giving to the GDE class.
//Find and Replace Node with the name of the class from Godot. (2 instances)

//Godot will be passing us a pointer to this struct during callbacks.
//MUST match what is used in the init function used to name our class. OdinArrays_SN


Class_String: cstring = "RefCounted"

OdinArrays :: struct (T: typeid) {
    selfPtr: ^GDE.Object,
    array: [dynamic]T
}

Odini64Array :: OdinArrays(GDE.Int)
OdinboolArray :: OdinArrays(GDE.Bool)
Odinf64Array :: OdinArrays(GDE.float)
OdinGDStringArray :: OdinArrays(GDE.gdstring)
OdinVec2Array :: OdinArrays(GDE.Vector2)
OdinVec2iArray :: OdinArrays(GDE.Vector2i)
OdinRec2Array :: OdinArrays(GDE.Rec2)
OdinRec2iArray :: OdinArrays(GDE.Rec2i)
OdinVec3Array :: OdinArrays(GDE.Vector3)
OdinVec3iArray :: OdinArrays(GDE.Vector3i)
OdinTrans2DArray :: OdinArrays(GDE.Transform2D)
OdinVec4Array :: OdinArrays(GDE.Vector4)
OdinVec4iArray :: OdinArrays(GDE.Vector4i)
OdinPlaneArray :: OdinArrays(GDE.Plane)
OdinQuatArray :: OdinArrays(GDE.Quaternion)
OdinAABBArray :: OdinArrays(GDE.AABB)
OdinBasisArray :: OdinArrays(GDE.Basis)
OdinTrans3DArray :: OdinArrays(GDE.Transform3D)
OdinProjectionArray :: OdinArrays(GDE.Projection)
OdinColorArray :: OdinArrays(GDE.Color)
OdinStringNameArray :: OdinArrays(GDE.StringName)
OdinNodePathArray :: OdinArrays(GDE.NodePath)
OdinRIDArray :: OdinArrays(GDE.RID)
OdinObjectArray :: OdinArrays(GDE.Object)
OdinCallableArray :: OdinArrays(GDE.Callable)
OdinSignalArray :: OdinArrays(GDE.Signal)
OdinDicArray :: OdinArrays(GDE.Dictionary)


//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
OdinArrayBindMethod :: proc "c" ($classStruct: typeid){
    context = runtime.default_context()


    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(&Odini64Array_SN, Odini64Array_CString, false)

    parent_class_name: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, Class_String, false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
    defer(GDW.Destructors.stringNameDestructor(&parent_class_name))

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    unref :: proc "c" (p_instance: GDE.ClassInstancePtr) {
        context = runtime.default_context()

        count: GDE.Int
        getRefCount(p_instance, ^classStruct, &count)
        if count <= 0 {
            if (cast(^classStruct)p_instance).array != nil {
                delete((cast(^classStruct)p_instance).array)
            }
            //Destroy(nil, p_instance)
            //GDW.Destructors.ObjectDestroy(p_instance)
            retVariant: GDE.Variant
            
            MethodName: GDE.StringName
            GDW.StringConstruct.stringNameNewLatin(&MethodName, "free", false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
            defer(GDW.Destructors.stringNameDestructor(&MethodName))
            //GDW.callDeferred(p_instance, &MethodName, &retVariant)
        }
    }

    //Delete all the heap allocated aspects of the class along with the class struct as well as any
    //additional nodes, canvasitems, area2d that you created. Like how bulletshower needs to do cleanup on the textures and phys objects.
    Destroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
        context = runtime.default_context()
        if (p_instance == nil){
            return
        }

        GDW.gdAPI.mem_free(cast(^classStruct)p_instance)

    }

    Create :: proc "c" (p_class_userdata: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
        context = runtime.default_context()

        class_name : GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&class_name, Class_String, false)
        defer(GDW.Destructors.stringNameDestructor(&class_name))
        object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)

        //Create our containing struct.
        //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
        self: ^classStruct = cast(^classStruct)GDW.gdAPI.mem_alloc(size_of(classStruct))
        self.selfPtr = object

        GDW.gdAPI.object_set_instance(object, &Odini64Array_SN, cast(^GDE.Object)self)
        GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

        return object
    }

    class_info: GDE.ClassCreationInfo4 = {
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
        unreference_func = unref,
        create_instance_func = Odini64ArrayCreate,
        free_instance_func = Destroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  Odini64ArraygetVirtualWithData,
        call_virtual_with_data_func = Odini64ArraycallVirtualFunctionWithData,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, &Odini64Array_SN, &parent_class_name, &class_info)
    
    
    Odini64Array_create :: proc "c" (classStruct: ^classStruct) {
        context = runtime.default_context()
        error: runtime.Allocator_Error
        classStruct.array, error = make_dynamic_array(type_of(classStruct.array))
        if error != nil {

        }
        fmt.println(classStruct.array)
    }

    GDW.bindMethod(&Odini64Array_SN, "Some_method_name", Odini64Array_create, GDE.ClassMethodFlags.NORMAL)
    //Same with this. It creates 4 extra functions. Getter, Setter, and variant callback, pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
    //GDW.makePublic(Odini64Array, "someProperty")


}


getRefCount :: proc(class: $T, $typeOf: typeid, r_int: ^GDE.Int) {
    @(static)getRefCount: GDE.MethodBindPtr
    if getRefCount == nil {
        GDClass_Name: GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&GDClass_Name, Class_String, false)
        getRefCount = GDW.classDBGetMethodBind2(&GDClass_Name, "get_reference_count", 3905245786)
    }
    
    
    GDW.gdAPI.objectMethodBindPtrCall(getRefCount, (cast(typeOf)class).selfPtr, nil, r_int)
}