package Toxin

import "shared:GDWrapper/gdAPI"
import GDW "shared:GDWrapper"

Maker :: proc {
    make_Node
}

Destroy_Builtin :: proc {
    GDArray_Methods.Destroy,
}