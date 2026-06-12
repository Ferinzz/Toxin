package main

import "core:os"
import "core:fmt"
import "base:runtime"
import "core:time"

main :: proc() {
    curr_work_dir, err:= os.get_working_directory(context.allocator)
    unit_test_dir_s:= fmt.aprint(curr_work_dir, "\\unit_tests", sep="")
    stress_test_dir_s:= fmt.aprint(curr_work_dir, "\\stress-test", sep="")
    total_time:= odin_check_directory(unit_test_dir_s)
    total_time+= odin_check_directory(stress_test_dir_s)
    delete(unit_test_dir_s)
    delete(stress_test_dir_s)
    
    fmt.println("total run time:", total_time)
}

odin_check_directory:: proc(dir_s: string) -> time.Duration {

    unit_test_dir, dir_err:= os.open(dir_s)
    if dir_err != nil {
        fmt.println("failed to open unit_tests directory.")
        return -1
    }
    test_dir:= os.read_directory_iterator_create(unit_test_dir)

    total_time: time.Duration
    for info in os.read_directory_iterator(&test_dir) {
        if info.type == .Directory{
        fmt.println(info.fullpath)
        process_desc:= os.Process_Desc{
            working_dir="",
            command= {"Odin", "check", info.fullpath, "-no-entry-point"}
        }
        descriptor:= info.name
        total_time+= run_proc(process_desc, descriptor)}
    }
	if path, err := os.read_directory_iterator_error(&test_dir); err != nil {
		fmt.eprintfln("read directory failed at %s: %s", path, err)
	}
    os.read_directory_iterator_destroy(&test_dir)
    os.close(unit_test_dir)
    return total_time
}

run_proc:: proc(process_desc: os.Process_Desc, desc: string) -> time.Duration {
    state, stdout, stderr, err:= os.process_exec(process_desc, context.allocator)
    if err != nil {
        fmt.println("process", desc, "failed with error: ", err)
        return -1
    }
    fmt.println("state:", state)
    fmt.println("stdout", string(stdout))
    if len(stderr) == 0 {
        fmt.println("no errors on build:", desc)
    } else {
        fmt.println("errors on build: ", desc, "\n", string(stderr))
    }
    delete(stderr)
    delete(stdout)
    return state.user_time + state.system_time
}