package type_tests

import "shared:Toxin"
import Classes "shared:Godot_Odin_Binds/GD_Classes"
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import "core:fmt"
import "base:runtime"
import "core:math"

init:: proc ()  {
    //Register custom class.
        fmt.println("I'm loading!!")
    type_test_deets.required.registerer->self_register(.INITIALIZATION_SCENE)
}

@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
}