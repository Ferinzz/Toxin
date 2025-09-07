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

when ODIN_DEBUG {
    isCreated: bool
}


OdinArrayBindMethod :: proc "c" ($classStruct: typeid, $className: cstring, className_SN: ^GDE.StringName, arrayProcs: ^$T/ArrayProcs, Class_String: cstring, loc:=#caller_location, ctx:=GDW.godotContext){
    context = ctx


    //Matching the name to the class struct is vital as it will be used in some binding helpers. If the name doesn't match things will break.
    GDW.StringConstruct.stringNameNewLatin(className_SN, className, false)

    parent_class_name: GDE.StringName
    GDW.StringConstruct.stringNameNewLatin(&parent_class_name, Class_String, false) //Node, Node2D, Sprite2D etc. MUST match what is used in class create.
    defer(GDW.Destructors.stringNameDestructor(&parent_class_name))

    stringraw:GDE.gdstring
    GDW.StringConstruct.stringNewLatin(&stringraw, "res://icon.svg")

    unref :: proc "c" (p_instance: GDE.ClassInstancePtr) {
        context = GDW.godotContext
        
        count: GDE.Int
        getRefCount(cast(^classStruct)p_instance, &count)
        if count <= 0 {
            if (cast(^classStruct)p_instance).data != nil {
            }

        }
    }
    
    getRefCount :: proc "c" (aclassStruct: ^classStruct, r_int: ^GDE.Int) {
        context = GDW.godotContext

        @(static)getRefCount: GDE.MethodBindPtr
        if getRefCount == nil {
            GDClass_Name: GDE.StringName
            GDW.StringConstruct.stringNameNewLatin(&GDClass_Name, Class_String, false)
            getRefCount = GDW.classDBGetMethodBind2(&GDClass_Name, "get_reference_count", 3905245786)
        }


        GDW.gdAPI.objectMethodBindPtrCall(getRefCount, aclassStruct.selfPtr, nil, r_int)
    }
    arrayProcs.getRefCount = getRefCount

    Reference :: proc "c" (aclassStruct: ^classStruct, r_bool: ^GDE.Bool) {
        context = GDW.godotContext

        @(static)reference: GDE.MethodBindPtr
        if reference == nil {
            GDClass_Name: GDE.StringName
            GDW.StringConstruct.stringNameNewLatin(&GDClass_Name, Class_String, false)
            reference = GDW.classDBGetMethodBind2(&GDClass_Name, "reference", 2240911060)
        }


        GDW.gdAPI.objectMethodBindPtrCall(reference, aclassStruct.selfPtr, nil, r_bool)
    }

    //Delete all the heap allocated aspects of the class along with the class struct as well as any
    //additional nodes, canvasitems, area2d that you created. Like how bulletshower needs to do cleanup on the textures and phys objects.
    Destroy :: proc "c" (p_class_userdata: rawptr, p_instance: GDE.ClassInstancePtr) {
        context = GDW.godotContext
        if (p_instance == nil){
            return
        }
        self := cast(^classStruct)p_instance
        when ODIN_DEBUG {
            self.isCreated = false
        }
        when classStruct == OdinStringNameArray {
            for &value in (cast(^classStruct)p_instance).data {
                old_value: GDE.Variant
                GDW.variant_from(&old_value, &value)
                fmt.println(value)
                old_value.VType = .STRING_NAME
                old_value.data[0] = transmute(u64)value
                GDW.Destructors.variantDestroy(&old_value)
            }
        }
        when classStruct == OdinGDStringArray {
            for &value in (cast(^classStruct)p_instance).data {
                old_value: GDE.Variant
                GDW.variant_from(&old_value, &value)
                fmt.println(value)
                old_value.VType = .STRING
                old_value.data[0] = transmute(u64)value
                GDW.Destructors.variantDestroy(&old_value)
            }
        }
        when classStruct == OdinObjectArray {
            for &value in (cast(^classStruct)p_instance).data {
                old_value: GDE.Variant
                GDW.variant_from(&old_value, &value)
                fmt.println(value)
                old_value.VType = .OBJECT
                old_value.data[0] = transmute(u64)value
                GDW.Destructors.variantDestroy(&old_value)
            }
        }
        when classStruct == OdinRIDArray {
            for &value in (cast(^classStruct)p_instance).data {
                old_value: GDE.Variant
                GDW.variant_from(&old_value, &value)
                fmt.println(value)
                old_value.VType = .RID
                old_value.data[0] = value.id
                old_value.data[1] = value.ptr
                GDW.Destructors.variantDestroy(&old_value)
            }
        }
        when classStruct == OdinSignalArray {
            for &value in (cast(^classStruct)p_instance).data {
                old_value: GDE.Variant
                GDW.variant_from(&old_value, &value)
                fmt.println(value)
                old_value.VType = .SIGNAL
                old_value.data[0] = transmute(u64)value.stringname
                old_value.data[1] = transmute(u64)value.objectid
                GDW.Destructors.variantDestroy(&old_value)
            }
        }
        delete((cast(^classStruct)p_instance).data)
        free(self)
    }
    
    Create :: proc "c" (p_class_userdata: rawptr, p_notify_postinitialize: GDE.Bool) -> GDE.ObjectPtr {
        context = GDW.godotContext
        
        class_name : GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&class_name, Class_String, false)
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

    to_string :: proc "c" (p_instance: GDE.ClassInstancePtr, r_is_valid: GDE.Bool, p_out: GDE.StringPtr) {
        context = GDW.godotContext
        /*
		{
			"name": "to_string",
			"is_const": false,
			"is_vararg": false,
			"is_static": false,
			"is_virtual": false,
			"hash": 2841200299,
			"return_value": {
				"type": "String"
			}
		},*/
        when classStruct == OdinStringNameArray {
            stringArray: GDE.PackedStringArray
            GDW.ArrayHelp.packedi32create0(&stringArray, nil)
            length:= len((cast(^classStruct)p_instance).data)*2 + 1
            args:=[1]rawptr {&length}
            r_ret: GDE.Int
            GDW.PackedStringArray.Resize(&stringArray, raw_data(args[:]), &r_ret, 1)
            stringBegin: GDE.gdstring
            GDW.StringConstruct.stringNewUTF8(&stringBegin, OdinStringNameArray_CString+"[")
            idx:=0
            
            args2:= [?]rawptr {&idx, &stringBegin}
            r_ret2: GDE.Bool
            fmt.println(GDW.PackedStringArray.Append)

            seperator_v: GDE.gdstring
            GDW.StringConstruct.stringNewUTF8(&seperator_v, ", ")
            //seperator:= GDW.fromvariant(&seperator_v, GDE.gdstring)

            GDW.PackedStringArray.Set(&stringArray,
                raw_data(args2[:]),
                &r_ret2, 2)
            for &value, i in (cast(^classStruct)p_instance).data[:] {
                idx:=i*2+1
                r_string: GDE.gdstring
                GDW.StringNameGetBasename(&value, &r_string)
                args:= [?]rawptr {&idx, &r_string}
                r_ret: GDE.Bool
                fmt.println(GDW.PackedStringArray.Append)
                GDW.PackedStringArray.Set(&stringArray,
                    raw_data(args[:]),
                    &r_ret, 2)
                
                idx+=1
                args= {&idx, &seperator_v}
                GDW.PackedStringArray.Set(&stringArray,
                    raw_data(args[:]),
                    &r_ret, 2)
            }
            stringEnd: GDE.gdstring
            GDW.StringConstruct.stringNewUTF8(&stringEnd, "]")
            length-=1
            args2= {&length, &stringEnd}
            
            GDW.PackedStringArray.Set(&stringArray,
                raw_data(args2[:]),
                &r_ret2, 2)
            
            r_string: GDE.gdstring
            GDW.GDStringJoin(&stringArray, p_out)
            GDW.PackedStringArray.Destroy(&stringArray)
            GDW.Destructors.stringDestruction(&stringEnd)
            GDW.Destructors.stringDestruction(&stringBegin)
            GDW.Destructors.stringDestruction(&seperator_v)
        } else
        when classStruct == OdinGDStringArray {
            stringArray: GDE.PackedStringArray
            GDW.ArrayHelp.packedi32create0(&stringArray, nil)
            length:= len((cast(^classStruct)p_instance).data)*2 + 1
            args:=[1]rawptr {&length}
            r_ret: GDE.Int
            GDW.PackedStringArray.Resize(&stringArray, raw_data(args[:]), &r_ret, 1)
            stringBegin: GDE.gdstring
            GDW.StringConstruct.stringNewUTF8(&stringBegin, OdinGDStringArray_CString+"[")
            idx:=0
            
            args2:= [?]rawptr {&idx, &stringBegin}
            r_ret2: GDE.Bool
            fmt.println(GDW.PackedStringArray.Append)

            seperator_v: GDE.gdstring
            GDW.StringConstruct.stringNewUTF8(&seperator_v, ", ")
            //seperator:= GDW.fromvariant(&seperator_v, GDE.gdstring)

            GDW.PackedStringArray.Set(&stringArray,
                raw_data(args2[:]),
                &r_ret2, 2)
            for &value, i in (cast(^classStruct)p_instance).data[:] {
                idx:=i*2+1
                r_string: GDE.gdstring
                //GDW.StringNameGetBasename(&value, &r_string)
                args:= [?]rawptr {&idx, &value}
                r_ret: GDE.Bool
                fmt.println(GDW.PackedStringArray.Append)
                GDW.PackedStringArray.Set(&stringArray,
                    raw_data(args[:]),
                    &r_ret, 2)
                
                idx+=1
                args= {&idx, &seperator_v}
                GDW.PackedStringArray.Set(&stringArray,
                    raw_data(args[:]),
                    &r_ret, 2)
            }
            stringEnd: GDE.gdstring
            GDW.StringConstruct.stringNewUTF8(&stringEnd, "]")
            length-=1
            args2= {&length, &stringEnd}
            
            GDW.PackedStringArray.Set(&stringArray,
                raw_data(args2[:]),
                &r_ret2, 2)
            
            r_string: GDE.gdstring
            GDW.GDStringJoin(&stringArray, p_out)
            GDW.PackedStringArray.Destroy(&stringArray)
            GDW.Destructors.stringDestruction(&stringEnd)
            GDW.Destructors.stringDestruction(&stringBegin)
            GDW.Destructors.stringDestruction(&seperator_v)
        }
        
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
        to_string_func = to_string,
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
            if classStruct.isCreated == true {
                GDW.Print.ErrorWithMessage("OdinArray", "Do not create array on existing array", "create", "OdinArrays", 258, true)
                return
            }
        }
        classStruct.data, error = make_dynamic_array(type_of(classStruct.data))
        if error != nil {

        }
        when ODIN_DEBUG {
            classStruct.isCreated = true
        }
    }

    arrayProcs.arcreate = arcreate
    GDW.bindMethod(className_SN, "create", arcreate, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arappend :: proc "c" (aclassStruct: ^classStruct, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        error: runtime.Allocator_Error
        count: int
        when ODIN_DEBUG {
            if aclassStruct.isCreated == false {
                aclassStruct.isCreated = true
                GDW.Print.WarningWithMessage("OdinArray", "Array being created via append", "append", "OdinArrays", 282, true)
            }
        }
        
        count, error = append_elem(&aclassStruct.data, value)
        if error != nil {

        }
    }
    arrayProcs.arappend = arappend
    GDW.bindMethod(className_SN, "append", arappend, GDE.ClassMethodFlags.NORMAL, "value")

    //*************\\
    arpop :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        
        ret = pop(&aclassStruct.data)
        GDW.tovariant(&ret, sics.type_elem_type(type_of(aclassStruct.data)))
        GDW.tovariant(&ret, sics.type_elem_type(type_of(aclassStruct.data)))
        GDW.tovariant(&ret, sics.type_elem_type(type_of(aclassStruct.data)))
        return
    }

    arrayProcs.arpop = arpop
    GDW.bindMethod(className_SN, "pop", arpop, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arset :: proc "c" (aclassStruct: ^classStruct, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        if len(aclassStruct.data) < index{ 
            aclassStruct.data[index] = value
        }
        //time.accurate_sleep(5000000000)
        
    }
    arrayProcs.arset = arset
    GDW.bindMethod(className_SN, "set", arset, GDE.ClassMethodFlags.NORMAL, "index", "value")

    //*************\\
    arlength :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = GDW.godotContext
        
        return len(aclassStruct.data)
    }
    arrayProcs.arlength = arlength
    GDW.bindMethod(className_SN, "length", arlength, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arraw_data :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = GDW.godotContext
        return int(uintptr(raw_data(aclassStruct.data[:])))
    }
    arrayProcs.arraw_data = arraw_data
    GDW.bindMethod(className_SN, "raw_data", arraw_data, GDE.ClassMethodFlags.NORMAL)

    //*************\\
    arcap :: proc "c" (aclassStruct: ^classStruct) -> GDE.Int {
        context = GDW.godotContext
        return cap(aclassStruct.data)
    }
    arrayProcs.arcap = arcap
    GDW.bindMethod(className_SN, "cap", arcap, GDE.ClassMethodFlags.NORMAL)

    
    //*************\\
    arunordered_remove :: proc "c" (aclassStruct: ^classStruct, index: int) {
        context = GDW.godotContext
        unordered_remove(&aclassStruct.data, index)
    }
    arrayProcs.arunordered_remove = arunordered_remove
    GDW.bindMethod(className_SN, "unordered_remove", arunordered_remove, GDE.ClassMethodFlags.NORMAL, "index")
    
    //*************\\
    arordered_remove :: proc "c" (aclassStruct: ^classStruct, index: int) {
        context = GDW.godotContext
        ordered_remove(&aclassStruct.data, index)
    }
    arrayProcs.arordered_remove = arordered_remove
    GDW.bindMethod(className_SN, "ordered_remove", arordered_remove, GDE.ClassMethodFlags.NORMAL, "index")
    
    //*************\\
    arremove_range :: proc "c" (aclassStruct: ^classStruct, low: int, high: int) {
        context = GDW.godotContext
        remove_range(&aclassStruct.data, low, high)
    }
    arrayProcs.arremove_range = arremove_range
    GDW.bindMethod(className_SN, "remove_range", arremove_range, GDE.ClassMethodFlags.NORMAL, "low", "high")
    
    //*************\\
    arpop_safe :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        ret, _ = pop_safe(&aclassStruct.data)
        return 
    }
    arrayProcs.arpop_safe = arpop_safe
    GDW.bindMethod(className_SN, "pop_safe", arpop_safe, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arpop_front :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        when ODIN_DEBUG {
            if len(aclassStruct.data) < 1 do GDW.Print.ErrorWithMessage("OdinArray", "array length < 0", "pop_front", "OdinArrays", 378, true)
            return
        }
        ret = pop_front(&aclassStruct.data)
        return 
    }
    arrayProcs.arpop_front = arpop_front
    GDW.bindMethod(className_SN, "pop_front", arpop_safe, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arpop_front_safe :: proc "c" (aclassStruct: ^classStruct) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        ok: bool
        if ret, ok = pop_front_safe(&aclassStruct.data); ok == false {
            GDW.Print.WarningWithMessage("OdinArray", "nothing to pop", "pop_front_safe", "OdinArrays", 378, true)
        }
        return 
    }
    arrayProcs.arpop_front_safe = arpop_front_safe
    GDW.bindMethod(className_SN, "pop_front_safe", arpop_front_safe, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    ardelete :: proc "c" (aclassStruct: ^classStruct) {
        context = GDW.godotContext
        when ODIN_DEBUG {
            if aclassStruct.isCreated == true do aclassStruct.isCreated = false
        }
        if aclassStruct.data != nil {
            delete(aclassStruct.data)
            aclassStruct.data = nil
        }
        
    }
    arrayProcs.ardelete = ardelete
    GDW.bindMethod(className_SN, "delete", ardelete, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    armake_len :: proc "c" (aclassStruct: ^classStruct, len: int) {
        context = GDW.godotContext
        aclassStruct.data, _ = make_dynamic_array_len(type_of(aclassStruct.data), len)
         
    }
    arrayProcs.armake_len = armake_len
    GDW.bindMethod(className_SN, "make_len", armake_len, GDE.ClassMethodFlags.NORMAL, "len")
    
    //*************\\
    arappend_nothing :: proc "c" (aclassStruct: ^classStruct) {
        context = GDW.godotContext
        append_nothing(&aclassStruct.data)
         
    }
    arrayProcs.arappend_nothing = arappend_nothing
    GDW.bindMethod(className_SN, "append_nothing", arappend_nothing, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arinject_at_elem :: proc "c" (aclassStruct: ^classStruct, index: int, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        inject_at_elem(&aclassStruct.data, index, value)
         
    }
    arrayProcs.arinject_at_elem = arinject_at_elem
    GDW.bindMethod(className_SN, "inject_at_elem", arinject_at_elem, GDE.ClassMethodFlags.NORMAL, "index", "value")
    
    //*************\\
    arassign_at_elem :: proc "c" (aclassStruct: ^classStruct, value: sics.type_elem_type(type_of(aclassStruct.data)), index: int) {
        context = GDW.godotContext
        value:=value
        when sics.type_elem_type(type_of(aclassStruct.data)) == GDE.StringName {
            value_V:= GDW.tovariant(&value, sics.type_elem_type(type_of(aclassStruct.data)))
            old_value: GDE.Variant
            GDW.variant_from(&old_value, &value)
            fmt.println(value)
            old_value.VType = .STRING_NAME
            old_value.data[0] = transmute(u64)&aclassStruct.data[index]
            GDW.Destructors.variantDestroy(&old_value)
        }
            
        when sics.type_elem_type(type_of(aclassStruct.data)) == GDE.gdstring {
            value_V:= GDW.tovariant(&value, sics.type_elem_type(type_of(aclassStruct.data)))
            old_value: GDE.Variant
            GDW.variant_from(&old_value, &value)
            fmt.println(value)
            old_value.VType = .STRING
            old_value.data[0] = transmute(u64)&aclassStruct.data[index]
            GDW.Destructors.variantDestroy(&old_value)
        }
            
        when sics.type_elem_type(type_of(aclassStruct.data)) == GDE.Object {
            value_V:= GDW.tovariant(&value, sics.type_elem_type(type_of(aclassStruct.data)))
            old_value: GDE.Variant
            GDW.variant_from(&old_value, &value)
            fmt.println(value)
            old_value.VType = .OBJECT
            old_value.data[0] = transmute(u64)&aclassStruct.data[index]
            GDW.Destructors.variantDestroy(&old_value)
        }
        when sics.type_elem_type(type_of(aclassStruct.data)) == GDE.RID {
            value_V:= GDW.tovariant(&value, sics.type_elem_type(type_of(aclassStruct.data)))
            old_value: GDE.Variant
            GDW.variant_from(&old_value, &value)
            fmt.println(value)
            old_value.VType = .RID
            old_value.data[0] = transmute(u64)&aclassStruct.data[index]
            GDW.Destructors.variantDestroy(&old_value)
        }
        when sics.type_elem_type(type_of(aclassStruct.data)) == GDE.Signal {
            value_V:= GDW.tovariant(&value, sics.type_elem_type(type_of(aclassStruct.data)))
            old_value: GDE.Variant
            GDW.variant_from(&old_value, &value)
            fmt.println(value)
            old_value.VType = .SIGNAL
            old_value.data[0] = transmute(u64)&aclassStruct.data[index].stringname
            old_value.data[1] = transmute(u64)&aclassStruct.data[index].objectid
            GDW.Destructors.variantDestroy(&old_value)
        }
        assign_at_elem(&aclassStruct.data, index, value)
        
    }
    arrayProcs.arassign_at_elem = arassign_at_elem
    GDW.bindMethod(className_SN, "assign_elem", arassign_at_elem, GDE.ClassMethodFlags.NORMAL, "index", "value")
    
    //*************\\
    arclear :: proc "c" (aclassStruct: ^classStruct) {
        context = GDW.godotContext
        clear(&aclassStruct.data)
        
    }
    arrayProcs.arclear = arclear
    GDW.bindMethod(className_SN, "clear", arclear, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    arresize :: proc "c" (aclassStruct: ^classStruct, size: int) {
        context = GDW.godotContext
        resize(&aclassStruct.data, size)
        
    }
    arrayProcs.arresize = arresize
    GDW.bindMethod(className_SN, "resize", arresize, GDE.ClassMethodFlags.NORMAL, "size")
    
    //*************\\
    arreserve :: proc "c" (aclassStruct: ^classStruct, size: int) {
        context = GDW.godotContext
        reserve(&aclassStruct.data, size)
        
    }
    arrayProcs.arreserve = arreserve
    GDW.bindMethod(className_SN, "reserve", arreserve, GDE.ClassMethodFlags.NORMAL, "size")
    
    //*************\\
    arshrink :: proc "c" (aclassStruct: ^classStruct) {
        context = GDW.godotContext
        shrink(&aclassStruct.data)
        
    }
    arrayProcs.arshrink = arshrink
    GDW.bindMethod(className_SN, "shrink", arshrink, GDE.ClassMethodFlags.NORMAL)
    
    //*************\\
    argetIndex :: proc "c" (aclassStruct: ^classStruct, index: GDE.Int) -> (ret: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        ret = aclassStruct.data[index]

        return
    }
    arrayProcs.argetIndex = argetIndex
    GDW.bindMethod(className_SN, "getIndex", argetIndex, GDE.ClassMethodFlags.NORMAL, "index")
    
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
    arrayProcs.arforEachbyStringName = arforEachbyStringName
    GDW.bindMethod(className_SN, "forEachby_SN", arforEachbyStringName, GDE.ClassMethodFlags.NORMAL, "object", "func")
    
    arforEach :: proc "c" (aclassStruct: ^classStruct, func: GDE.Callable) {
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
    arrayProcs.arforEach = arforEach
    GDW.bindMethod(className_SN, "forEach", arforEach, GDE.ClassMethodFlags.NORMAL, "func")
    
    arFill :: proc "c" (aclassStruct: ^classStruct, value: sics.type_elem_type(type_of(aclassStruct.data))) {
        context = GDW.godotContext
        
        for &i, index in aclassStruct.data {
            i = value
        }
    }
    arrayProcs.arFill = arFill
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
    arrayProcs.arFillEach = arFillEach
    GDW.bindMethod(className_SN, "fillEach", arFillEach, GDE.ClassMethodFlags.NORMAL, "func")
    


    arSlice: proc "c" (aclassStruct: ^classStruct) -> GDE.Object
    switch typeid_of(classStruct) {
        case typeid_of(Odini64Array): 
            arSlice = proc "c" (aclassStruct: ^classStruct) -> GDE.Object {
                context = GDW.godotContext
                some: GDE.Object
                Odini64Arrayprocs.Create(nil, false)
                return some
            }
    }

    arrayProcs.arSlice = arSlice
    GDW.bindMethod(className_SN, "Slice", arSlice, GDE.ClassMethodFlags.NORMAL)
    
    arSliceRange :: proc "c" (aclassStruct: ^classStruct, start: GDE.Int, length: GDE.Int) {
        context = GDW.godotContext
        
    }
    arrayProcs.arSliceRange = arSliceRange
    GDW.bindMethod(className_SN, "SliceRange", arSliceRange, GDE.ClassMethodFlags.NORMAL, "start", "length")
    // when ODIN_DEBUG {
    //     fmt.println(arrayProcs)
    // }
}



@export
getRefCount :: proc(Object: GDE.ObjectPtr, r_int: ^GDE.Int) {
    @(static)getRefCount: GDE.MethodBindPtr
    if getRefCount == nil {
        GDClass_Name: GDE.StringName
        GDW.StringConstruct.stringNameNewLatin(&GDClass_Name, Class_String, false)
        getRefCount = GDW.classDBGetMethodBind2(&GDClass_Name, "get_reference_count", 3905245786)
    }
    
    
    GDW.gdAPI.objectMethodBindPtrCall(getRefCount, Object, nil, r_int)
}