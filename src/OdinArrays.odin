package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"
import sics "base:intrinsics"

//Find and Replace OdinArrays with the name that you will be giving to the GDE class.
//Find and Replace Node with the name of the class from Godot. (2 instances)

//Godot will be passing us a pointer to this struct during callbacks.
//MUST match what is used in the init function used to name our class. OdinArrays_SN


Class_String: cstring = "RefCounted"

OdinArrays :: struct (T: typeid) {
    selfPtr: ^GDE.Object,
    data: [dynamic]T
}

Odini64Array :: OdinArrays(GDE.Int)
Odini64Array_SN: GDE.StringName
Odini64Array_CString:: "Odini64Array"

OdinBoolArray :: OdinArrays(GDE.Bool)
OdinBoolArray_SN: GDE.StringName
OdinBoolArray_CString:: "OdinBoolArray"

Odinf64Array :: OdinArrays(GDE.float)
Odinf64Array_SN: GDE.StringName
Odinf64Array_CString:: "Odinf64Array"

OdinGDStringArray :: OdinArrays(GDE.gdstring)
OdinGDStringArray_SN: GDE.StringName
OdinGDStringArray_CString:: "OdinGDStringArray"

OdinVec2Array :: OdinArrays(GDE.Vector2)
OdinVec2Array_SN: GDE.StringName
OdinVec2Array_CString:: "OdinVec2Array"

OdinVec2iArray :: OdinArrays(GDE.Vector2i)
OdinVec2iArray_SN: GDE.StringName
OdinVec2iArray_CString:: "OdinVec2iArray"

OdinRec2Array :: OdinArrays(GDE.Rec2)
OdinRec2Array_SN: GDE.StringName
OdinRec2Array_CString:: "OdinRec2Array"

OdinRec2iArray :: OdinArrays(GDE.Rec2i)
OdinRec2iArray_SN: GDE.StringName
OdinRec2iArray_CString:: "OdinRec2iArray"

OdinVec3Array :: OdinArrays(GDE.Vector3)
OdinVec3Array_SN: GDE.StringName
OdinVec3Array_CString:: "OdinVec3Array"

OdinVec3iArray :: OdinArrays(GDE.Vector3i)
OdinVec3iArray_SN: GDE.StringName
OdinVec3iArray_CString:: "OdinVec3iArray"

OdinTrans2DArray :: OdinArrays(GDE.Transform2D)
OdinTrans2DArray_SN: GDE.StringName
OdinTrans2DArray_CString:: "OdinTrans2DArray"

OdinVec4Array :: OdinArrays(GDE.Vector4)
OdinVec4Array_SN: GDE.StringName
OdinVec4Array_CString:: "OdinVec4Array"

OdinVec4iArray :: OdinArrays(GDE.Vector4i)
OdinVec4iArray_SN: GDE.StringName
OdinVec4iArray_CString:: "OdinVec4iArray"

OdinPlaneArray :: OdinArrays(GDE.Plane)
OdinPlaneArray_SN: GDE.StringName
OdinPlaneArray_CString:: "OdinPlaneArray"

OdinQuatArray :: OdinArrays(GDE.Quaternion)
OdinQuatArray_SN: GDE.StringName
OdinQuatArray_CString:: "OdinQuatArray"

OdinAABBArray :: OdinArrays(GDE.AABB)
OdinAABBArray_SN: GDE.StringName
OdinAABBArray_CString:: "OdinAABBArray"

OdinBasisArray :: OdinArrays(GDE.Basis)
OdinBasisArray_SN: GDE.StringName
OdinBasisArray_CString:: "OdinBasisArray"

OdinTrans3DArray :: OdinArrays(GDE.Transform3D)
OdinTrans3DArray_SN: GDE.StringName
OdinTrans3DArray_CString:: "OdinTrans3DArray"

OdinProjectionArray :: OdinArrays(GDE.Projection)
OdinProjArray_SN: GDE.StringName
OdinProjArray_CString:: "OdinProjectionArray"

OdinColorArray :: OdinArrays(GDE.Color)
OdinColorArray_SN: GDE.StringName
OdinColorArray_CString:: "OdinColorArray"

OdinStringNameArray :: OdinArrays(GDE.StringName)
OdinStringNameArray_SN: GDE.StringName
OdinStringNameArray_CString:: "OdinStrinNameArray"

OdinNodePathArray :: OdinArrays(GDE.NodePath)
OdinNodePathArray_SN: GDE.StringName
OdinNodePathArray_CString:: "OdinNodePathArray"

OdinRIDArray :: OdinArrays(GDE.RID)
OdinRIDArray_SN: GDE.StringName
OdinRIDArray_CString:: "OdinRIDArray"

OdinObjectArray :: OdinArrays(GDE.Object)
OdinObjectArray_SN: GDE.StringName
OdinObjectArray_CString:: "OdinObjectArray"

OdinCallableArray :: OdinArrays(GDE.Callable)
OdinCallableArray_SN: GDE.StringName
OdinCallableArray_CString:: "OdinCallableArray"

OdinSignalArray :: OdinArrays(GDE.Signal)
OdinSignalArray_SN: GDE.StringName
OdinSignalArray_CString:: "OdinSignalArray"

OdinDicArray :: OdinArrays(GDE.Dictionary)
OdinDicArray_SN: GDE.StringName
OdinDicArray_CString:: "OdinDicArray"


//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
OdinArrayBindMethod :: proc "c" ($classStruct: typeid, $className: cstring, className_SN: ^GDE.StringName){
    context = runtime.default_context()


    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(className_SN, className, false)

    parent_class_name: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, Class_String, false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
    defer(GDW.Destructors.stringNameDestructor(&parent_class_name))

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    unref :: proc "c" (p_instance: GDE.ClassInstancePtr) {
        context = runtime.default_context()
        someArray:=(cast(^classStruct)p_instance).data
        count: GDE.Int
        getRefCount(p_instance, ^classStruct, &count)
        if count <= 0 {
            if (cast(^classStruct)p_instance).data != nil {
                delete((cast(^classStruct)p_instance).data)
            }
            //Destroy(nil, p_instance)
            //GDW.Destructors.ObjectDestroy(p_instance)
            retVariant: GDE.Variant
            /*
            MethodName: GDE.StringName
            GDW.StringConstruct.stringNameNewLatin(&MethodName, "free", false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
            defer(GDW.Destructors.stringNameDestructor(&MethodName))*/
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

        
        className_SN : GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&className_SN, className, false)
        defer(GDW.Destructors.stringNameDestructor(&className_SN))
        //Create our containing struct.
        //Maybe can replace mem_alloc with new(). This should be safe as we own the free in the destroy callback.
        self: ^classStruct = cast(^classStruct)GDW.gdAPI.mem_alloc(size_of(classStruct))
        self.selfPtr = object

        GDW.gdAPI.object_set_instance(object, &className_SN, cast(^GDE.Object)self)
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
        create_instance_func = Create,
        free_instance_func = Destroy,
        recreate_instance_func = nil,
        get_virtual_func = nil,
        get_virtual_call_data_func =  nil,
        call_virtual_with_data_func = nil,
        class_userdata = nil, 
    }

    GDW.gdAPI.classDBRegisterExtClass(GDW.Library, className_SN, &parent_class_name, &class_info)
    
    
    Odini64Array_create :: proc "c" (classStruct: ^classStruct) {
        context = runtime.default_context()
        error: runtime.Allocator_Error
        classStruct.data, error = make_dynamic_array(type_of(classStruct.data))
        if error != nil {

        }
        fmt.println(classStruct.data)
    }

    GDW.bindMethod(className_SN, "Some_method_name", Odini64Array_create, GDE.ClassMethodFlags.NORMAL)
    //Same with this. It creates 4 extra functions. Getter, Setter, and variant callback, pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
    //GDW.makePublic(Odini64Array, "someProperty")

    //*************\\
    arcreate :: proc "c" (classStruct: ^classStruct) {
        context = runtime.default_context()
        error: runtime.Allocator_Error
        classStruct.data, error = make_dynamic_array(type_of(classStruct.data))
        if error != nil {

        }
        fmt.println(classStruct.data)
    }

    GDW.bindMethod(className_SN, "create", arcreate, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arappend :: proc "c" (aclassStruct: ^classStruct, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        error: runtime.Allocator_Error
        count: int
        count, error = append_elem(&aclassStruct.data, value)
        if error != nil {

        }
    }

    GDW.bindMethod(className_SN, "append", arappend, GDE.ClassMethodFlags.NORMAL, "value")

    //*************\\
    arpop :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        error: runtime.Allocator_Error
        count: int
        ret = pop(&aclassStruct.data)
        if error != nil {

        }
        return
    }

    GDW.bindMethod(className_SN, "pop", arpop, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arset :: proc "c" (aclassStruct: ^classStruct, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        if len(aclassStruct.data) < index{ 
            aclassStruct.data[index] = value
        }
        
    }

    GDW.bindMethod(className_SN, "set", arset, GDE.ClassMethodFlags.NORMAL, "index", "value")

    //*************\\
    arlength :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = runtime.default_context()
        return len(aclassStruct.data)
    }

    GDW.bindMethod(className_SN, "length", arlength, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arraw_data :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = runtime.default_context()
        return int(uintptr(raw_data(aclassStruct.data[:])))
    }

    GDW.bindMethod(className_SN, "raw_data", arraw_data, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arcap :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = runtime.default_context()
        return cap(aclassStruct.data)
    }

    GDW.bindMethod(className_SN, "cap", arcap, GDE.ClassMethodFlags.NORMAL)

    
    //*************\\
    arunordered_remove :: proc "c" (aclassStruct: ^classStruct, index: int) {
        context = runtime.default_context()
        unordered_remove(&aclassStruct.data, index)
    }

    GDW.bindMethod(className_SN, "unordered_remove", arunordered_remove, GDE.ClassMethodFlags.NORMAL, "index")
    
    //*************\\
    arordered_remove :: proc "c" (aclassStruct: ^classStruct, index: int) {
        context = runtime.default_context()
        ordered_remove(&aclassStruct.data, index)
    }

    GDW.bindMethod(className_SN, "ordered_remove", arordered_remove, GDE.ClassMethodFlags.NORMAL, "index")
    
    //*************\\
    arremove_range :: proc "c" (aclassStruct: ^classStruct, low: int, high: int) {
        context = runtime.default_context()
        remove_range(&aclassStruct.data, low, high)
    }

    GDW.bindMethod(className_SN, "remove_range", arremove_range, GDE.ClassMethodFlags.NORMAL, "low", "high")
    
    //*************\\
    arpop_safe :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        ret, _ = pop_safe(&aclassStruct.data)
        return 
    }

    GDW.bindMethod(className_SN, "pop_safe", arpop_safe, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arpop_front :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        ret = pop_front(&aclassStruct.data)
        return 
    }

    GDW.bindMethod(className_SN, "pop_front", arpop_safe, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arpop_front_safe :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        ret, _ = pop_front_safe(&aclassStruct.data)
        return 
    }

    GDW.bindMethod(className_SN, "pop_front_safe", arpop_front_safe, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    ardelete :: proc "c" (aclassStruct: ^classStruct) {
        context = runtime.default_context()
        delete(aclassStruct.data)
         
    }

    GDW.bindMethod(className_SN, "delete", ardelete, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    armake_len :: proc "c" (aclassStruct: ^classStruct, len: int) {
        context = runtime.default_context()
        aclassStruct.data, _ = make_dynamic_array_len(type_of(aclassStruct.data), len)
         
    }

    GDW.bindMethod(className_SN, "make_len", armake_len, GDE.ClassMethodFlags.NORMAL, "len")
    
    //*************\\
    arappend_nothing :: proc "c" (aclassStruct: ^classStruct) {
        context = runtime.default_context()
        append_nothing(&aclassStruct.data)
         
    }

    GDW.bindMethod(className_SN, "append_nothing", arappend_nothing, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arinject_at_elem :: proc "c" (aclassStruct: ^classStruct, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        inject_at_elem(&aclassStruct.data, index, value)
         
    }

    GDW.bindMethod(className_SN, "inject_at_elem", arinject_at_elem, GDE.ClassMethodFlags.NORMAL, "index", "value")
    
    //*************\\
    arassign_at_elem :: proc "c" (aclassStruct: ^classStruct, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = runtime.default_context()
        assign_at_elem(&aclassStruct.data, index, value)
        
    }

    GDW.bindMethod(className_SN, "assign_elem", arassign_at_elem, GDE.ClassMethodFlags.NORMAL, "index", "value")
    
    //*************\\
    arclear :: proc "c" (aclassStruct: ^classStruct) {
        context = runtime.default_context()
        clear(&aclassStruct.data)
        
    }

    GDW.bindMethod(className_SN, "clear", arclear, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arresize :: proc "c" (aclassStruct: ^classStruct, size: int) {
        context = runtime.default_context()
        resize(&aclassStruct.data, size)
        
    }

    GDW.bindMethod(className_SN, "resize", arresize, GDE.ClassMethodFlags.NORMAL, "size")
    
    //*************\\
    arreserve :: proc "c" (aclassStruct: ^classStruct, size: int) {
        context = runtime.default_context()
        reserve(&aclassStruct.data, size)
        
    }

    GDW.bindMethod(className_SN, "reserve", arreserve, GDE.ClassMethodFlags.NORMAL, "size")
    
    //*************\\
    arshrink :: proc "c" (aclassStruct: ^classStruct) {
        context = runtime.default_context()
        shrink(&aclassStruct.data)
        
    }

    GDW.bindMethod(className_SN, "shrink", arshrink, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arget :: proc "c" (aclassStruct: ^classStruct, index: int) -> sics.type_elem_type(type_of(aclassStruct.data)) {
        context = runtime.default_context()
        return aclassStruct.data[index]
        
    }

    GDW.bindMethod(className_SN, "arget", arget, GDE.ClassMethodFlags.NORMAL, "index")
    
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