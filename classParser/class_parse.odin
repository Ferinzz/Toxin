package main

import "core:os"
import "core:fmt"
import "core:strings"
import "base:runtime"
//import "core:os"


main :: proc() {

	buf: [256]u8
	iRead, _ := os.read(os.stdin, buf[:])
	//fmt.println(buf)


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

	fmt.println(string(filecontents))

	indx:= strings.index(string(filecontents), "\"constants")
	fmt.println(string(filecontents[:indx]))
	
	start:= strings.index(string(filecontents[indx:]), "[") + indx
	//fmt.println(string(filecontents[indx:indx+32]))

	end:= strings.index(string(filecontents[start:]), "]") + start
	fmt.println(string(filecontents[start:end]))
	
	//ending, err:= getEnd(string(filecontents), start)

	endPos, content, _ := getContentsToEnd(string(filecontents), start)

	fmt.println(string(content[:]))

	output:[dynamic]u8
	append(&output, "ControlConstants :: enum i32 {")
	newString, was_allocation:= strings.replace(string(content[:]), "name>>>", `
	`, -1)
	delete(content)
	newString2, _:= strings.replace(newString[:], ">>>value>>>", " = ", -1)
	delete(newString)
	newString3, _:= strings.replace(newString2[:], ">>>", ",", -1)
	delete(newString2)

	fmt.println(newString3)

	append(&output, newString3)
	delete(newString3)

	append(&output, `
}`)

	fmt.println(string(output[:]))

	
	indx= strings.index(string(filecontents), "\"enums")
	
	start= strings.index(string(filecontents[indx:]), "[") + indx

	end= strings.index(string(filecontents[start:]), "]") + start

	isComma: u8 = ','
	for isComma == ','{
		start = strings.index(string(filecontents[indx:]), "{") + indx

		//fmt.println(string(filecontents[start:end]))
		

		endPos, content, _ = getContentsToEnd(string(filecontents), start)

		append(&output, "\n\n")
		index := strings.index(string(content[7:]), ">>>") + 7
		append(&output, string(content[7:index]))
		
		newString, _ = strings.replace(string(content[index:]), "name>>>", `
	`, -1)
		delete(content)
		newString2, _ = strings.replace(newString[:], ">>>is_bitfield>>>values>>>", " :: enum {", -1)
		delete(newString)
		newString, _= strings.replace(newString2[:], ">>>value>>>", " = ", -1)
		delete(newString2)
		fmt.println(newString)
		newString2, _= strings.replace(newString[:], ">>>", ",", -1)
		delete(newString)

		append(&output, newString2)
		delete(newString2)

		append(&output, `
}`)

		fmt.println(string(output[:]))

		isComma = filecontents[endPos+1]
		indx = endPos
	}


	
	indx= strings.index(string(filecontents), "\"methods")
	
	start= strings.index(string(filecontents[indx:]), "[") + indx

	end= strings.index(string(filecontents[start:]), "]") + start

	someMethod: methodData
	isComma = ','
	loopcount:i32
	for isComma == ','{
		fmt.println(loopcount)
		loopcount+=1
		start = strings.index(string(filecontents[indx:]), "{") + indx

		//fmt.println(string(filecontents[start:end]))
		

		endPos, someMethod = getMethodInfo(string(filecontents), start)
		fmt.println(string(filecontents[endPos:endPos +2]))

		append(&output, `

`)		
		append(&output, someMethod.name)
		append(&output, " :: proc \"c\" (")
		
		if len(someMethod.args) > 0 {
			argSplit:= strings.split(someMethod.args[0].name, ">>>")
			for split in argSplit{
				fmt.println("splits", split[:])
			}
			
			for i:=0; i<len(argSplit)-1; i+=2 {
				append(&output, argSplit[i])
				append(&output, ": ^GDE.")
				append(&output, argSplit[i+1])
				if i < len(argSplit)-3{
					append(&output, ", ")
				}
			}
		}
		append(&output, ") {")
		
/*
`getLastMouseVelocity :: proc "c" (r_v2Pos: ^GDE.Vector2) {
    context = runtime.default_context()
    @(static)GetLastMouseVelocity: GDE.MethodBindPtr
    if GetLastMouseVelocity == nil do GetLastMouseVelocity = classDBGetMethodBind2(&Input_SN, "get_last_mouse_velocity", 1497962370)

    assert(InputSingleton != nil)
    gdAPI.objectMethodBindPtrCall(GetLastMouseVelocity, InputSingleton, nil, r_v2Pos)
}`*/

		isComma = filecontents[endPos+1]
		indx = endPos
	}
	fmt.println(string(output[:]))
}







getNextErr :: enum {
	Start_Value_not_Correct,
	EOF
}

getContentsToEnd :: proc(s: string, index: int, allocator:= context.allocator) -> (res:int, content: [dynamic]u8, err:getNextErr) {
	inside:= false

	if (s[index] != '{' && s[index] != '[') {
		return -1, {}, .Start_Value_not_Correct
	}
	
	inner:[dynamic]u8
	append(&inner, s[index])
	defer(delete(inner))
	for i := 1; i<len(s); i+=1 {
		if s[index+i] == '"'{
			quoteEnd:int
			quoteEnd, _ = getQuotedEnd(s, index+i)
			append(&content, s[index+i+1:quoteEnd])
			if s[index+i+1:quoteEnd] == "value" || s[index+i+1:quoteEnd] == "hash" || s[index+i+1:quoteEnd] == "is_vararg" {
				append(&content, ">>>")
				lineEnd:= strings.index_byte(s[index+i:], '\r')
				append(&content, s[quoteEnd+3:lineEnd+index+i])
			}
			append(&content, ">>>")
			i = quoteEnd - index
		}
		if (s[index+i] == '{' || s[index+i] == '[') {
			
			append(&inner, s[index])
		}
		
		if (s[index+i] == '}' || s[index+i] == ']') {
			pop(&inner)
			if len(inner) == 0
			{
				return i+index, content, nil
			}
		}

	}
	return -1, {}, .EOF
}

getQuotedEnd :: proc(s: string, index: int) -> (res:int, err: getNextErr) {
	res=index
	skip: u8 = '\\'
	i:i32
	for skip == '\\'{
		
		res = strings.index_byte(s[res+1:], '"') + res+1
		skip = s[res-1]
	}
	return res, nil
	
}

methodData:: struct {
	name: string,
	vararg: string,
	hash: string,
	returnVal: string,
	args: [dynamic]procArgs,
}

procArgs :: struct {
	name: string,
	type: string,
}

getMethodInfo :: proc(s: string, index: int) -> (res: int, output: methodData) {
	
	if (s[index] != '{') {
		return -1, output
	}
	err: getNextErr
	res = index
	inner:[dynamic]u8
	defer(delete(inner))
	append(&inner, s[index])
	for i:=res; i < len(s); i=res {
		res+=1
		if (s[res] == '}' || s[res] == ']') {
			pop(&inner)
			if len(inner) == 0  {
				fmt.println(output)
				return res, output
			}
		}
		if (s[res] == '{' || s[res] == '[') {
			append(&inner, s[res])
		}

		quoteEnd: int
		if s[res] == '"' {
			quoteEnd, err = getQuotedEnd(s, res)
			if err != nil {
				return -1, output
			}
			//fmt.println(s[res:quoteEnd])
			switch s[res+1:quoteEnd] {
			case "hash":
				lineEnd:= strings.index_byte(s[quoteEnd+3:], '\r')+quoteEnd+3
				output.hash = s[quoteEnd+3:lineEnd]
				res=lineEnd
			
			case "is_vararg":
				lineEnd:= strings.index_byte(s[quoteEnd+3:], '\r')+quoteEnd+3
				output.vararg = s[quoteEnd+3:lineEnd]
				res = lineEnd
			
			case "name":
				fmt.println(s[res:quoteEnd])
				res=quoteEnd+4
				quoteEnd, _ = getQuotedEnd(s, res)
				fmt.println(s[res:quoteEnd])
				output.name = s[res:quoteEnd]
				res = quoteEnd+1
			
			case "return_value":
				returnEnd, content, _ := getContentsToEnd(s, quoteEnd+3)
				output.returnVal, _ = strings.remove(string(content[:]), "type>>>", 1)
				delete(content)
				res = returnEnd + 1

			case "arguments":
				returnEnd, content, _ := getContentsToEnd(s, quoteEnd+3)
				theseargs:procArgs
				newString, _ := strings.remove(string(content[:]), "type>>>", -1)
				delete(content)
				newString2, _ := strings.remove(string(newString[:]), "name>>>", -1)
				delete(newString)
				theseargs.name = newString2
				append(&output.args, theseargs)
				
				res = returnEnd + 1
				
			}
		}
	}

	return res, output
}


//find constants, convert to enum with i32 size.
//enums check if bitfield -> if false with i32 else normal odin enum
//methods 
//const doesn't matter since we're just calling it. There are no virtual functions which are also const.
//varargs, the last value of the args list will be varargs. it's all stringnames from what I can tell.
//static doesn't matter?
//virtual... add as comment, but these all start with _*
//hash
//return value. Always only one.
//arguments. Either enum, base types, object
//Signals are just stringnames. We can declare them global and allow the user to add them to the init phase so that they get added to the available list.
//Signal argument should be comments.
//Properties looks like a PITA. instead of specifying the type as vec4 it lists them individually and provides their index and name.
/*
	{
		"name": "_structured_text_parser",
		"is_const": true,
		"is_static": false,
		"is_required": false,
		"is_vararg": false,
		"is_virtual": true,
		"hash": 1292548940,
		"return_value": {
			"type": "typedarray::Vector3i"
		},
		"arguments": [
			{
				"name": "args",
				"type": "Array"
			},
			{
				"name": "text",
				"type": "String"
			}
		]
	},
*/