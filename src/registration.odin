package main

import "Toxin"
import "base:runtime"

init:: proc "c" (userdata: rawptr)  {
    context = runtime.default_context()
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets
    THIS_CLASS_NAME_deets.required.registerer->self_register(.INITIALIZATION_SCENE)
}

@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets
}