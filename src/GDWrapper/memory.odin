package GDWrapper

import "base:runtime"
import GDE "gdextension"
import "core:strings"
import "base:intrinsics"
import "core:time"


godotContext: runtime.Context


initGodotContext :: proc "contextless" () {
    godotContext = runtime.default_context()
    godotContext.assertion_failure_proc = failureProc
    
}

failureProc :: proc(prefix, message: string, loc: runtime.Source_Code_Location) -> ! {
    context = godotContext

    cprefix, _:= strings.clone_to_cstring(prefix)
    cmessage, _:= strings.clone_to_cstring(message)
    cprocedure, _ := strings.clone_to_cstring(loc.procedure)
    cfilePath, _:= strings.clone_to_cstring(loc.file_path)

    Print.ErrorWithMessage(cprefix, cmessage, cprocedure, cfilePath, loc.line, true)
    //time.sleep(5_000_000_000)
    for i:=0; i<5_000_00000; i+=1 {
        somevar:= i
        somevar+=1
        //Print.ErrorWithMessage("OdinArray", "nothing to pop", "append", "OdinArrays", 378, true)
        
    }
	intrinsics.trap()
}