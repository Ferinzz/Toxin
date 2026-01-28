package main

import "Toxin"

init:: proc "contextless" ()  {
    Toxin.scene_inits[0] = &THIS_CLASS_NAME_deets
}

@(init)
asdf :: proc "contextless" () {
    //Toxin.inits.scene = init
    init()
}