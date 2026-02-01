package main

import "Toxin"

init:: proc ()  {
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets
    THIS_CLASS_NAME_deets.registerer->self_register(.INITIALIZATION_SCENE)
}

@(init)
asdf :: proc "contextless" () {
    Toxin.inits.scene = init
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets
}