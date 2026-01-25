package GDWrapper

import GDE "gdAPI/gdextension"
import "gdAPI"

texture2D :: GDE.ObjectPtr

destroy_texture :: proc(texture: texture2D) {
    die:GDE.RID
    if texture != nil && texture.proxy != nil {
        getRid(texture, &die)
        freeRenderRID(&die)
    }
}