package main

import "core:os"
import "core:fmt"
import "base:runtime"

main :: proc() {
    curr_work_dir, err:= os.get_working_directory(context.allocator)
    unit_test_dir_s:= fmt.aprint(curr_work_dir, "\\unit_tests", sep="")
    stress_test_dir_s:= fmt.aprint(curr_work_dir, "\\stress-test", sep="")
    odin_check_directory(unit_test_dir_s)
    odin_check_directory(stress_test_dir_s)
}

odin_check_directory:: proc(dir_s: string) {
    
    unit_test_dir, dir_err:= os.open(dir_s)
    if dir_err != nil {
        fmt.println("failed to open unit_tests directory.")
        return
    }
    test_dir:= os.read_directory_iterator_create(unit_test_dir)
    

    for info in os.read_directory_iterator(&test_dir) {
        if info.type == .Directory{
        fmt.println(info.fullpath)
        process_desc:= os.Process_Desc{
            working_dir="",
            command= {"Odin", "check", info.fullpath, "-no-entry-point"}
        }
        descriptor:= info.name
        run_proc(process_desc, descriptor)}
    }
    os.read_directory_iterator_destroy(&test_dir)
    os.close(unit_test_dir)
}

run_proc:: proc(process_desc: os.Process_Desc, desc: string) {
    state, stdout, stderr, err:= os.process_exec(process_desc, context.allocator)
    if err != nil {
        fmt.println("process", desc, "failed with error: ", err)
        return
    }
    fmt.println("state:", state)
    fmt.println("stdout", string(stdout))
    if len(stderr) == 0 {
        fmt.println("no errors on file:", desc)
    } else {
        fmt.println("errors on file: ", desc, "\n", string(stderr))
    }
    delete(stderr)
    delete(stdout)
}