package main

import GDW "GDWrapper"
import GDE "GDWrapper/gdextension"
import "base:runtime"
import "core:fmt"
import sics "base:intrinsics"
import "core:time"
import "core:strconv"
import "core:slice"


//Find and Replace OdinArrays with the name that you will be giving to the GDE class.
//Find and Replace Node with the name of the class from Godot. (2 instances)

//Godot will be passing us a pointer to this struct during callbacks.
//MUST match what is used in the init function used to name our class. OdinArrays_SN


OdinSliceParentClass: cstring = "RefCounted"



//make some function public to Godot's scripts.
//Doesn't have to be in a separate function from the init but it makes it easier to locate where to update.
OdinSliceBindMethod :: proc "c" ($classStruct: typeid, $className: cstring, className_SN: ^GDE.StringName){
    context = GDW.godotContext


    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(className_SN, className, false)

    parent_class_name: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, OdinSliceParentClass, false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
    defer(GDW.Destructors.stringNameDestructor(&parent_class_name))

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    unref :: proc "c" (p_instance: GDE.ClassInstancePtr) {
        context = GDW.godotContext
        
        count: GDE.Int
        getRefCount(p_instance, ^classStruct, &count)
        if count <= 0 {
            if (cast(^classStruct)p_instance).data != nil {
                delete((cast(^classStruct)p_instance).data)
            }

        }
    }

    //Delete all the heap allocated aspects of the class along with the class struct as well as any
    //additional nodes, canvasitems, area2d that you created. Like how bulletshower needs to do cleanup on the textures and phys objects.
    Destroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
        context = GDW.godotContext
        if (p_instance == nil){
            return
        }
        when ODIN_DEBUG {
            isCreated = false
        }
        free(p_instance)
    }

    Create :: proc "c" (p_class_userdata: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
        context = GDW.godotContext
        
        //time.accurate_sleep(5000000000)
        class_name : GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&class_name, OdinSliceParentClass, false)
        defer(GDW.Destructors.stringNameDestructor(&class_name))
        object: GDE.ObjectPtr = GDW.gdAPI.classDBConstructObj(&class_name)        
        
        className_SN : GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&className_SN, className, false)
        defer(GDW.Destructors.stringNameDestructor(&className_SN))

        //Create our containing struct.
        self:= new(classStruct)
        self.selfPtr = object
        self.type = sics.type_elem_type(type_of(self.data))

        GDW.gdAPI.object_set_instance(object, &className_SN, cast(^GDE.Object)self)
        GDW.gdAPI.object_set_instance_binding(object, GDW.Library, self, &classBindingCallbacks)

        return object
    }

    CreateObject :: proc (array: $E/[dynamic]$T) -> GDE.ObjectPtr {
        return Create(nil, false)

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
    
    //Same with this. It creates 4 extra functions. Getter, Setter, and variant callback, pointer callback.
    //If you only need part of this or want to do more specific actions during a 'get' or 'set' you can always write the functions
    //as normal and call bindMethod and then bindProperty.
    //GDW.makePublic(Odini64Array, "someProperty")

    //*************\\
    arcreate :: proc "c" (classStruct: ^classStruct) {
        context = GDW.godotContext
        error: runtime.Allocator_Error
        when ODIN_DEBUG {
            if isCreated == true {
                GDW.Print.ErrorWithMessage("OdinArray", "Do not create array on existing array", "create", "OdinSlice", 258, true)
                return
            }
        }
        if error != nil {

        }
        when ODIN_DEBUG {
            isCreated = true
        }
    }

    GDW.bindMethod(className_SN, "create", arcreate, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arset :: proc "c" (aclassStruct: ^classStruct, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        if len(aclassStruct.data) < index{ 
            aclassStruct.data[index] = value
        }
        //time.accurate_sleep(5000000000)
        
    }

    GDW.bindMethod(className_SN, "set", arset, GDE.ClassMethodFlags.NORMAL, "index", "value")

    //*************\\
    arlength :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = GDW.godotContext
        //time.accurate_sleep(5000000000)
        return len(aclassStruct.data)
    }

    GDW.bindMethod(className_SN, "length", arlength, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arraw_data :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = GDW.godotContext
        return int(uintptr(raw_data(aclassStruct.data[:])))
    }

    GDW.bindMethod(className_SN, "raw_data", arraw_data, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    ardelete :: proc "c" (aclassStruct: ^classStruct) {
        context = GDW.godotContext
        when ODIN_DEBUG {
            if isCreated == true do isCreated = false
        }
        if aclassStruct.data != nil {
            delete(aclassStruct.data)
            aclassStruct.data = nil
        }
        
    }

    GDW.bindMethod(className_SN, "delete", ardelete, GDE.ClassMethodFlags.NORMAL)
    

    //*************\\
    arassign_at_elem :: proc "c" (aclassStruct: ^classStruct, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        if index < len(aclassStruct.data) {
            aclassStruct.data[index] = value
        }
        
    }

    GDW.bindMethod(className_SN, "assign_elem", arassign_at_elem, GDE.ClassMethodFlags.NORMAL, "index", "value")
    
    //*************\\
    argetIndex :: proc "c" (aclassStruct: ^classStruct, index: GDE.Int) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        ret = aclassStruct.data[index]
        return
    }

    GDW.bindMethod(className_SN, "getIndex", argetIndex, GDE.ClassMethodFlags.NORMAL, "index")
    
    //*************\\
    arforAll :: proc "c" (aclassStruct: ^classStruct) {
        context = GDW.godotContext
        for i, index in aclassStruct.data {
            fmt.printfln("value: %v  at index: %v", i, index)
        }
    }

    GDW.bindMethod(className_SN, "forAll", arforAll, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arforEachbyStringName :: proc "c" (aclassStruct: ^classStruct, object: GDE.Object, func_SN: GDE.StringName) {
        context = GDW.godotContext
        error: GDE.CallError
        funcPtr:=func_SN
        for &i, index in aclassStruct.data {
            ind:= index
            args: [2]rawptr = {&i, &ind}
            dummyReturn:rawptr= nil
            GDW.gdAPI.callScript(cast(^GDE.Object)(object.proxy), &funcPtr, raw_data(args[:]), 0, &dummyReturn, &error)
        }
    }

    GDW.bindMethod(className_SN, "forEachby_SN", arforEachbyStringName, GDE.ClassMethodFlags.NORMAL, "object", "func")
    
    forEach :: proc "c" (aclassStruct: ^classStruct, func: GDE.Callable) {
        context = GDW.godotContext
        
        error: GDE.CallError
        function:= func

        args:= [0]rawptr {}
        Object: GDE.ObjectPtr

        GDW.Callable.get_object(&function, raw_data(args[:]), &Object, 0)
        for &i, index in aclassStruct.data {
            ind:= index
            args: [2]rawptr = {&i, &ind}
            dummyReturn2: GDE.Variant
            GDW.gdAPI.callScript(Object, &function.stringName, raw_data(args[:]), 0, &dummyReturn2, &error)
            GDW.fromvariant(&dummyReturn2, sics.type_elem_type(type_of(aclassStruct.data)))
            
        }
    }

    GDW.bindMethod(className_SN, "forEach", forEach, GDE.ClassMethodFlags.NORMAL, "func")
    
    arFill :: proc "c" (aclassStruct: ^classStruct, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        
        for &i, index in aclassStruct.data {
            i = value
        }
    }

    GDW.bindMethod(className_SN, "fill", arFill, GDE.ClassMethodFlags.NORMAL, "value")
    
    arFillEach :: proc "c" (aclassStruct: ^classStruct, func: GDE.Callable) {
        context = GDW.godotContext
            
        error: GDE.CallError
        function:= func

        args:= [0]rawptr {}
        Object: GDE.ObjectPtr

        GDW.Callable.get_object(&function, raw_data(args[:]), &Object, 0)
        for &i, index in aclassStruct.data {
            ind:= index
            args: [2]rawptr = {&i, &ind}
            dummyReturn2: GDE.Variant
            GDW.gdAPI.callScript(Object, &function.stringName, raw_data(args[:]), 0, &dummyReturn2, &error)
            i = GDW.fromvariant(&dummyReturn2, sics.type_elem_type(type_of(aclassStruct.data)))
            
        }
    }

    GDW.bindMethod(className_SN, "fillEach", arFillEach, GDE.ClassMethodFlags.NORMAL, "func")
    
}
