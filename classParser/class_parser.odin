package main

import "core:os"
import "core:fmt"
import "core:strings"

//Fun fact, since this was written to support C even if it says something is bitfield it will provide the specific int value
//On Odin side maybe it could be annoying for setting flags, but passing through the api it won't make a difference.

getNextErr :: enum {
	Start_Value_not_Correct,
	EOF
}

segments :: struct {
    constants: [][]u8,
    enums: [][]u8,
    methods: [][]u8,
    signals: [][]u8,
}

CONSTANTS   :: "\"constants\""
ENUMS       :: "\"enums\""
METHODS     :: "\"methods\""
SIGNALS     :: "\"signals\""

main :: proc() {
    buf: [256]u8
	iRead, _ := os.read(os.stdin, buf[:])
    
    filehandle: os.Handle
    ok:os.Error
	fmt.println(string(buf[:iRead-2]))
    if filehandle, ok = os.open(string(buf[:iRead-2])); ok == nil{
        fmt.println("opened")
    }
    else{
        fmt.println("failed to open file")
        fmt.println("error : ", ok)
        return
    }
    
    defer os.close(filehandle)

	filecontents, _ := os.read_entire_file_from_handle(filehandle)

    contents: segments

    //"constants"
    //"enums"
    //"methods"
    //"signals"
    constStart:= strings.index(string(filecontents[:]), CONSTANTS)

    enumsStart:= strings.index(string(filecontents[:]), ENUMS)
    
    methodsStart:= strings.index(string(filecontents[:]), METHODS)

    signalsStart:= strings.index(string(filecontents[:]), SIGNALS)
    
    className: []u8
	output: [dynamic]u8

    {
    dataStart:int

    if constStart >=0 {
        dataStart = constStart    
    } else
    if enumsStart >=0 {
        dataStart = enumsStart
    } else
    if methodsStart >=0 {
        dataStart = methodsStart
    } else
    if signalsStart >=0 {
        dataStart = signalsStart
    } else do return

    
    append(&output, `#+ignore
package GDWrapper

import GDE "gdextension"
import "base:runtime"

/*
`)
    append(&output, string(filecontents[:dataStart]))
    append(&output, `
*/`)
    nameloc:=strings.index(string(filecontents[:dataStart]), "name")
    assert(nameloc < dataStart, "include the class metadata please. Will need the name for later.")
    nameEnd,_ := getQuotedEnd(filecontents[:], nameloc+7)
    className = filecontents[nameloc+8:nameEnd-1]
    }

    index:=constStart

    //*****************\\
    //****Constants****\\
    //*****************\\
    if constStart > 0 {
        constEntry:= fmt.aprintfln("\n%sConstants :: enum i64 {{", className[:])
        append(&output, constEntry[:])
        delete(constEntry)
        for char in filecontents[constStart:] {
            if char == '[' do break
            index+=1
        }
        //fmt.println(string(filecontents[index:index+1]))
        contents.constants, index = separate(filecontents, index)

        for segment in contents.constants[:] {
            //fmt.println(string(segment[:]))

        }
        
        append(&output, `
`)
        for i:=0; i<len(contents.constants); i+=4 {
            append(&output, fmt.aprintf(`   %s%s = %s,
`, className[:], contents.constants[i+1], contents.constants[i+3]))
        }
        append(&output, `}

`)
    }
    //fmt.println(string(output[:]))
    
    //**************\\
    //*****Enums****\\
    //**************\\
    if enumsStart > 0 {
        index=enumsStart
        isMore:u8= ','
        for isMore == ','{
            for char in filecontents[index:] {
                if char == '{' do break
                index+=1
            }

            contents.enums, index = separate(filecontents, index)
            enumDecl:=fmt.aprintf("\n\n%s :: enum i32 {{\n", contents.enums[1][:])
            append(&output, enumDecl)
            delete(enumDecl)
            for i:=4; i< len(contents.enums)-3; i+=4 {
                value:= fmt.aprintfln(" %s = %s,", contents.enums[i+1][:],contents.enums[i+3][:])
                append(&output, value)
                delete(value)
            }
            append(&output, "}")
            isMore = filecontents[index+1]
            delete(contents.enums)
            
        }
        //fmt.println(string(output[:]))
    }
    
    //*****************\\
    //*****Methods*****\\
    //*****************\\
    if methodsStart > 0 {
        append(&output, `



    //*****************\\
    //*****Methods*****\\
    //*****************\\

`)
        index=methodsStart
        isMore:u8= ','
        for isMore == ','{
            for char in filecontents[index:] {
                if char == '{' do break
                index+=1
            }

            contents.methods, index = separate(filecontents, index)
            /*
            name index 1
            vararg index 4
            hash 8
            then check for return_value if true
            return type index 11
            check for arguments
            get name+type until end of array.
            */
        addMethodStart:= len(output) - 1
        arguments:= false
        argIndex:int
        areReturn:= false
        retIndex:int
        vararg:=false
        comment: [dynamic]u8
        argPlace: [dynamic]int
        defer(delete(argPlace))
        defer(delete(comment))
        hashIndex:int

        for s, indx in contents.methods[:]{
            if string(s[:]) == "hash" do hashIndex = indx +1
        }

        for s, i in contents.methods {
            if string(s[:]) == "arguments" {
                arguments = true
                argIndex = i
            }
            if string(s[:]) == "return_value" {
                areReturn = true
                retIndex = i
            }
            if string(s[:]) == "is_vararg" && filecontents[i+1] == 't' {
                append(&comment, `
//is vararg`)
                vararg = true
        }
        }

        argPlace = make([dynamic]int, (len(contents.methods) - argIndex)/2)

        append(&output, fmt.aprintf(`%s :: proc "c" (%s: GDE.ObjectPtr`, contents.methods[1][:], className[:])) //methodname
        if arguments {
            append(&output, ", ")
            for i:= argIndex+1; i < len(contents.methods)-3+4*int(vararg); i+=4 {
                append(&output, fmt.aprintf(`%s: ^%s, `, contents.methods[i+1][:], replaceType(contents.methods[i+3][:]))) //argumentname, argumenttype
                meta:=false
                if (len(contents.methods) > i + 4 && string(contents.methods[i+4][:]) == "meta") {
                    append(&comment, fmt.aprintf(`
//Meta of %s : %s`, contents.methods[i+1][:], contents.methods[i+5][:]))
                    i+=2
                    meta=true
                }
                    if (len(contents.methods) > i + 4 && string(contents.methods[i+4][:]) == "default_value") {
                    append(&comment, fmt.aprintf(`
//default of %s : %s`, contents.methods[i+1-2*int(meta)][:], contents.methods[i+5][:]))
                        i+=2
                    }

            }
            if vararg {
                last:=len(contents.methods)-4
                append(&output, fmt.aprintf(`%s: [^]%s`, contents.methods[last][:], contents.methods[last+2][:])) //keeping the ,space
            }
            else {
                pop(&output)
                pop(&output)
            }
        }
        //can only be one return value, so only need to add one.
        if areReturn {
            append(&output, fmt.aprintf(`, r_ret: ^%s`, replaceType(contents.methods[retIndex+2][:])))
        }
        append(&output, `) {
`)


        append(&output, fmt.aprintf(`    context = runtime.default_context()
    @(static)%s: GDE.MethodBindPtr
    if %s == nil do %s = classDBGetMethodBind("%s", "%s", %s)
    assert(%s != nil)`,
            strings.to_upper(string(contents.methods[1][:])),
            strings.to_upper(string(contents.methods[1][:])),
            strings.to_upper(string(contents.methods[1][:])),
            className[:],
            contents.methods[1][:],
            contents.methods[hashIndex][:],
            className[:]
            )) //method name all caps, methodname all caps, classname, methodname, hash
        //fmt.println("isarguments: ", arguments)
        if arguments {
            append(&output, `
    args:= [?]rawptr { `)
                //fmt.println("argindex: ", argIndex)
            for i:= argIndex+1; i < len(contents.methods); i+=4 {
                append(&output, fmt.aprintf(`%s, `, contents.methods[i+1][:])) //argumentname
                //fmt.println("arguments ", string(contents.methods[i+1][:]))
                if (len(contents.methods) > i + 4 && string(contents.methods[i+4][:]) == "meta") {
                    i+=2
                }
                if (len(contents.methods) > i + 4 && string(contents.methods[i+4][:]) == "default_value") {
                    i+=2
                }
            }
            pop(&output)
            pop(&output)
            append(&output, ` }`)
            append(&output, fmt.aprintf(`
    gdAPI.objectMethodBindPtrCall(%s, %s, raw_data(args[:]), `, strings.to_upper(string(contents.methods[1][:])), className[:]))
            
        }
        else {
            append(&output, fmt.aprintf(`
    gdAPI.objectMethodBindPtrCall(%s, %s, nil, `, strings.to_upper(string(contents.methods[1][:])), className[:]))
        }

        if areReturn {
            append(&output, `r_ret)
}

`)
        }
        else {
            append(&output, `nil)
}

`)
        }
        if len(comment) > 0 {
            inject_at(&output, addMethodStart+1, fmt.aprintf("%s%s", string(comment[:]), `
`))
        }
            isMore = filecontents[index+1]
            delete(contents.methods)
            
        }
    }
    
    //*******************\\
    //******Signals******\\
    //*******************\\
    if signalsStart > 0 {
        index=signalsStart
        
        append(&output, fmt.aprintf(`%sSignals :: enum {{`, className[:]))
        isMore:u8= ','
        for isMore == ','{
            for char in filecontents[index:] {
                if char == '{' do break
                index+=1
            }

            contents.signals, index = separate(filecontents, index)

            for i:=0; i < len(contents.signals)-1; i+=2 {
                switch string(contents.signals[i][:]) {
                    case "name":
                        append(&output, fmt.aprintf(`
    %s = "%s",`, contents.signals[i+1][:], contents.signals[i+1][:]))
                    case "arguments":
                        append(&output, "//Args")
                        for args:=i+1; args<len(contents.signals)-3; args+=4{
                            append(&output, fmt.aprintf(` //%s: %s`, contents.signals[args][:], replaceType(contents.signals[args+3][:])))
                        }
                }
//                 append(&output, `
// `)
            }
            isMore = filecontents[index+1]
            delete(contents.signals)
            
        }
        append(&output, `
}`)
    }


    //fmt.println(string(output[:]))
    fmt.println(string(className[:]))

    fmt.println("success writing: ", os.write_entire_file("C:\\Odin_programs\\toxin_new_pull\\classParser\\output.odin", output[:]))

}

count :: proc(s: []u8, indx: int) -> (counter: int) {
    if (s[indx] != '[' && s[indx] != '{') do return -1

    inner: [dynamic]u8
    defer(delete(inner))
    append(&inner, s[indx])
    i:=indx+1
    for ; i<len(s); i+=1 {
        switch s[i] {
            case '[', '{':
                append(&inner, s[i])

            case '}', ']':
                pop(&inner)
            case ':' :
                counter += 1
        }
        if len(inner) <= 0 do return
    }
    return 
}

separate :: proc(s: []u8, indx: int) -> (list: [][]u8, endPos: int) {
    if (s[indx] != '[' && s[indx] != '{') {
        endPos = -1
        return
    }

    n:= count(s, indx)
    list = make([][]u8, n*2)
    listIndex:= 0
    inner: [dynamic]u8
    defer(delete(inner))
    append(&inner, s[indx])
    i:=indx+1
    for ; i<len(s); i+=1 {
        switch s[i] {
            case '[', '{':
                append(&inner, s[i])

            case '}', ']':
                pop(&inner)
            case '"':
                end, _ := getQuotedEnd(s, i)
                list[listIndex]=s[i+1:end-1]
                listIndex+=1
                switch string(s[i+1:end-1]) {
                    case "is_vararg":
                        list[listIndex] = s[end+2:end+3]
                        listIndex+=1
                    case "hash":
                        end2, _ := index_of_byte(s[end:], '\n')
                        if s[end2+end-1] == '\r' do end2 -=1
                        list[listIndex] = s[end+2:end2+end-1]
                        listIndex+=1
                    case "value":
                        end2, _ := index_of_byte(s[end:], '\n')
                        if s[end2+end-1] == '\r' do end2 -=1
                        list[listIndex] = s[end+2:end2+end]
                        listIndex+=1
                }
                i= end+1
        }
        if len(inner) <= 0 {
            endPos = i
            return list[:listIndex], endPos
        }
        
    }
    return
}


getQuotedEnd :: proc(s: []u8, index: int) -> (res:int, err: getNextErr) {
    if s[index] != '"' do return -1, .Start_Value_not_Correct
	res=index + 1
	skip: u8 = '\\'
	i:i32
	for skip == '\\'{
		
		end, _ := index_of_byte(s[res:], '"')
        res +=  end +1
		skip = s[res-2]
	}
	return res, nil
	
}

index_of_byte :: proc(s: []u8, getByte: u8) -> (res: int, err: getNextErr) {
    for i:=0; i < len(s); i+=1 {
        if s[i] == getByte do return i, nil
    }
    return -1, .EOF
}

replaceType :: proc (s: []u8) -> string {
    switch string(s[:]) {
	    case "bool": 
            return "GDE.Bool"
	    case "int": 
            return "GDE.Int"
	    case "float": 
            return "GDE.float"
	    case "String": 
            return "GDE.gdstring"
	    case "Vector2": 
            return "GDE.Vector2"
	    case "Vector2i": 
            return "GDE.Vector2i"
	    case "Rect2": 
            return "GDE.Rec2"
	    case "Rect2i": 
            return "GDE.Rec2i"
	    case "Vector3": 
            return "GDE.Vector4"
	    case "Vector3i": 
            return "GDE.Vector4i"
	    case "Transform2D": 
            return "GDE.trans2d"
	    case "Vector4":
            return "GDE. Vector4"
	    case "Vector4i": 
            return "GDE.Vector4i"
	    case "Plane": 
            return "GDE.Plane"
	    case "Quaternion": 
            return "GDE.Quaternion"
	    case "AABB": 
            return "GDE.AABB"
	    case "Basis": 
            return "GDE.Basis"
	    case "Transform3D": 
            return "GDE.Transform3D"
	    case "Projection": 
            return "GDE.Projection"
	    case "Color": 
            return "GDE.Color"
	    case "StringName": 
            return "GDE.StringName"
	    case "NodePath": 
            return "GDE.NodePath"
	    case "RID": 
            return "GDE.RID"
	    case "Object": 
            return "GDE.Object"
	    case "Callable": 
            return "GDE.Callable"
	    case "Signal": 
            return "GDE.Signal"
	    case "Dictionary": 
            return "GDE.Dictionary"
	    case "Array": 
            return "GDE.Array"
	    case "PackedByteArray": 
            return "GDE.PackedByteArray"
	    case "PackedInt32Array": 
            return "GDE.PackedInt32Array"
	    case "PackedInt64Array": 
            return "GDE.PackedInt64Array"
	    case "PackedFloat32Array": 
            return "GDE.PackedFloat32Array"
	    case "PackedFloat64Array": 
            return "GDE.PackedFloat64Array"
	    case "PackedStringArray": 
            return "GDE.PackedStringArray"
	    case "PackedVector2Array": 
            return "GDE.PackedVector2Array"
	    case "PackedVector3Array": 
            return "GDE.PackedVector3Array"
	    case "PackedColorArray": 
            return "GDE.PackedColorArray"
	    case "PackedVector4Array": 
            return "GDE.PackedVector4Array"
	    case "Variant": 
            return "GDE.Variant"
    }
    if len(s) >= 4 && (string(s[0:4]) == "enum" || string(s[0:4]) == "bitf") {
        start,_ := index_of_byte(s[:], '.')
        if start == -1 {
            start,_ = index_of_byte(s[:], ':')
            start += 1
        }
        return string(s[start+1:])
    }
    return "GDE.ObjectPtr"
}