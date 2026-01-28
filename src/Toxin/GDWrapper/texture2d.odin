package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

texture2D :: ^Object

destroy_texture :: proc(texture: texture2D) {
    die:RID
    if texture != nil && texture.proxy != nil {
        getRid(texture, &die)
        freeRenderRID(&die)
    }
}