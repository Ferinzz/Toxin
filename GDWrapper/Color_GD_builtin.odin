package GDWrapper

import "gdAPI"
import GDE "gdAPI/gdextension"
import "core:math"


@(rodata)
Color_ALICE_BLUE : Color= {0.9411765, 0.972549, 1, 1}
@(rodata)
Color_ANTIQUE_WHITE : Color= {0.98039216, 0.92156863, 0.84313726, 1}
@(rodata)
Color_AQUA : Color= {0, 1, 1, 1}
@(rodata)
Color_AQUAMARINE : Color= {0.49803922, 1, 0.83137256, 1}
@(rodata)
Color_AZURE : Color= {0.9411765, 1, 1, 1}
@(rodata)
Color_BEIGE : Color= {0.9607843, 0.9607843, 0.8627451, 1}
@(rodata)
Color_BISQUE : Color= {1, 0.89411765, 0.76862746, 1}
@(rodata)
Color_BLACK : Color= {0, 0, 0, 1}
@(rodata)
Color_BLANCHED_ALMOND : Color= {1, 0.92156863, 0.8039216, 1}
@(rodata)
Color_BLUE : Color= {0, 0, 1, 1}
@(rodata)
Color_BLUE_VIOLET : Color= {0.5411765, 0.16862746, 0.8862745, 1}
@(rodata)
Color_BROWN : Color= {0.64705884, 0.16470589, 0.16470589, 1}
@(rodata)
Color_BURLYWOOD : Color= {0.87058824, 0.72156864, 0.5294118, 1}
@(rodata)
Color_CADET_BLUE : Color= {0.37254903, 0.61960787, 0.627451, 1}
@(rodata)
Color_CHARTREUSE : Color= {0.49803922, 1, 0, 1}
@(rodata)
Color_CHOCOLATE : Color= {0.8235294, 0.4117647, 0.11764706, 1}
@(rodata)
Color_CORAL : Color= {1, 0.49803922, 0.3137255, 1}
@(rodata)
Color_CORNFLOWER_BLUE : Color= {0.39215687, 0.58431375, 0.92941177, 1}
@(rodata)
Color_CORNSILK : Color= {1, 0.972549, 0.8627451, 1}
@(rodata)
Color_CRIMSON : Color= {0.8627451, 0.078431375, 0.23529412, 1}
@(rodata)
Color_CYAN : Color= {0, 1, 1, 1}
@(rodata)
Color_DARK_BLUE : Color= {0, 0, 0.54509807, 1}
@(rodata)
Color_DARK_CYAN : Color= {0, 0.54509807, 0.54509807, 1}
@(rodata)
Color_DARK_GOLDENROD : Color= {0.72156864, 0.5254902, 0.043137256, 1}
@(rodata)
Color_DARK_GRAY : Color= {0.6627451, 0.6627451, 0.6627451, 1}
@(rodata)
Color_DARK_GREEN : Color= {0, 0.39215687, 0, 1}
@(rodata)
Color_DARK_KHAKI : Color= {0.7411765, 0.7176471, 0.41960785, 1}
@(rodata)
Color_DARK_MAGENTA : Color= {0.54509807, 0, 0.54509807, 1}
@(rodata)
Color_DARK_OLIVE_GREEN : Color= {0.33333334, 0.41960785, 0.18431373, 1}
@(rodata)
Color_DARK_ORANGE : Color= {1, 0.54901963, 0, 1}
@(rodata)
Color_DARK_ORCHID : Color= {0.6, 0.19607843, 0.8, 1}
@(rodata)
Color_DARK_RED : Color= {0.54509807, 0, 0, 1}
@(rodata)
Color_DARK_SALMON : Color= {0.9137255, 0.5882353, 0.47843137, 1}
@(rodata)
Color_DARK_SEA_GREEN : Color= {0.56078434, 0.7372549, 0.56078434, 1}
@(rodata)
Color_DARK_SLATE_BLUE : Color= {0.28235295, 0.23921569, 0.54509807, 1}
@(rodata)
Color_DARK_SLATE_GRAY : Color= {0.18431373, 0.30980393, 0.30980393, 1}
@(rodata)
Color_DARK_TURQUOISE : Color= {0, 0.80784315, 0.81960785, 1}
@(rodata)
Color_DARK_VIOLET : Color= {0.5803922, 0, 0.827451, 1}
@(rodata)
Color_DEEP_PINK : Color= {1, 0.078431375, 0.5764706, 1}
@(rodata)
Color_DEEP_SKY_BLUE : Color= {0, 0.7490196, 1, 1}
@(rodata)
Color_DIM_GRAY : Color= {0.4117647, 0.4117647, 0.4117647, 1}
@(rodata)
Color_DODGER_BLUE : Color= {0.11764706, 0.5647059, 1, 1}
@(rodata)
Color_FIREBRICK : Color= {0.69803923, 0.13333334, 0.13333334, 1}
@(rodata)
Color_FLORAL_WHITE : Color= {1, 0.98039216, 0.9411765, 1}
@(rodata)
Color_FOREST_GREEN : Color= {0.13333334, 0.54509807, 0.13333334, 1}
@(rodata)
Color_FUCHSIA : Color= {1, 0, 1, 1}
@(rodata)
Color_GAINSBORO : Color= {0.8627451, 0.8627451, 0.8627451, 1}
@(rodata)
Color_GHOST_WHITE : Color= {0.972549, 0.972549, 1, 1}
@(rodata)
Color_GOLD : Color= {1, 0.84313726, 0, 1}
@(rodata)
Color_GOLDENROD : Color= {0.85490197, 0.64705884, 0.1254902, 1}
@(rodata)
Color_GRAY : Color= {0.74509805, 0.74509805, 0.74509805, 1}
@(rodata)
Color_GREEN : Color= {0, 1, 0, 1}
@(rodata)
Color_GREEN_YELLOW : Color= {0.6784314, 1, 0.18431373, 1}
@(rodata)
Color_HONEYDEW : Color= {0.9411765, 1, 0.9411765, 1}
@(rodata)
Color_HOT_PINK : Color= {1, 0.4117647, 0.7058824, 1}
@(rodata)
Color_INDIAN_RED : Color= {0.8039216, 0.36078432, 0.36078432, 1}
@(rodata)
Color_INDIGO : Color= {0.29411766, 0, 0.50980395, 1}
@(rodata)
Color_IVORY : Color= {1, 1, 0.9411765, 1}
@(rodata)
Color_KHAKI : Color= {0.9411765, 0.9019608, 0.54901963, 1}
@(rodata)
Color_LAVENDER : Color= {0.9019608, 0.9019608, 0.98039216, 1}
@(rodata)
Color_LAVENDER_BLUSH : Color= {1, 0.9411765, 0.9607843, 1}
@(rodata)
Color_LAWN_GREEN : Color= {0.4862745, 0.9882353, 0, 1}
@(rodata)
Color_LEMON_CHIFFON : Color= {1, 0.98039216, 0.8039216, 1}
@(rodata)
Color_LIGHT_BLUE : Color= {0.6784314, 0.84705883, 0.9019608, 1}
@(rodata)
Color_LIGHT_CORAL : Color= {0.9411765, 0.5019608, 0.5019608, 1}
@(rodata)
Color_LIGHT_CYAN : Color= {0.8784314, 1, 1, 1}
@(rodata)
Color_LIGHT_GOLDENROD : Color= {0.98039216, 0.98039216, 0.8235294, 1}
@(rodata)
Color_LIGHT_GRAY : Color= {0.827451, 0.827451, 0.827451, 1}
@(rodata)
Color_LIGHT_GREEN : Color= {0.5647059, 0.93333334, 0.5647059, 1}
@(rodata)
Color_LIGHT_PINK : Color= {1, 0.7137255, 0.75686276, 1}
@(rodata)
Color_LIGHT_SALMON : Color= {1, 0.627451, 0.47843137, 1}
@(rodata)
Color_LIGHT_SEA_GREEN : Color= {0.1254902, 0.69803923, 0.6666667, 1}
@(rodata)
Color_LIGHT_SKY_BLUE : Color= {0.5294118, 0.80784315, 0.98039216, 1}
@(rodata)
Color_LIGHT_SLATE_GRAY : Color= {0.46666667, 0.53333336, 0.6, 1}
@(rodata)
Color_LIGHT_STEEL_BLUE : Color= {0.6901961, 0.76862746, 0.87058824, 1}
@(rodata)
Color_LIGHT_YELLOW : Color= {1, 1, 0.8784314, 1}
@(rodata)
Color_LIME : Color= {0, 1, 0, 1}
@(rodata)
Color_LIME_GREEN : Color= {0.19607843, 0.8039216, 0.19607843, 1}
@(rodata)
Color_LINEN : Color= {0.98039216, 0.9411765, 0.9019608, 1}
@(rodata)
Color_MAGENTA : Color= {1, 0, 1, 1}
@(rodata)
Color_MAROON : Color= {0.6901961, 0.1882353, 0.3764706, 1}
@(rodata)
Color_MEDIUM_AQUAMARINE : Color= {0.4, 0.8039216, 0.6666667, 1}
@(rodata)
Color_MEDIUM_BLUE : Color= {0, 0, 0.8039216, 1}
@(rodata)
Color_MEDIUM_ORCHID : Color= {0.7294118, 0.33333334, 0.827451, 1}
@(rodata)
Color_MEDIUM_PURPLE : Color= {0.5764706, 0.4392157, 0.85882354, 1}
@(rodata)
Color_MEDIUM_SEA_GREEN : Color= {0.23529412, 0.7019608, 0.44313726, 1}
@(rodata)
Color_MEDIUM_SLATE_BLUE : Color= {0.48235294, 0.40784314, 0.93333334, 1}
@(rodata)
Color_MEDIUM_SPRING_GREEN : Color= {0, 0.98039216, 0.6039216, 1}
@(rodata)
Color_MEDIUM_TURQUOISE : Color= {0.28235295, 0.81960785, 0.8, 1}
@(rodata)
Color_MEDIUM_VIOLET_RED : Color= {0.78039217, 0.08235294, 0.52156866, 1}
@(rodata)
Color_MIDNIGHT_BLUE : Color= {0.09803922, 0.09803922, 0.4392157, 1}
@(rodata)
Color_MINT_CREAM : Color= {0.9607843, 1, 0.98039216, 1}
@(rodata)
Color_MISTY_ROSE : Color= {1, 0.89411765, 0.88235295, 1}
@(rodata)
Color_MOCCASIN : Color= {1, 0.89411765, 0.70980394, 1}
@(rodata)
Color_NAVAJO_WHITE : Color= {1, 0.87058824, 0.6784314, 1}
@(rodata)
Color_NAVY_BLUE : Color= {0, 0, 0.5019608, 1}
@(rodata)
Color_OLD_LACE : Color= {0.99215686, 0.9607843, 0.9019608, 1}
@(rodata)
Color_OLIVE : Color= {0.5019608, 0.5019608, 0, 1}
@(rodata)
Color_OLIVE_DRAB : Color= {0.41960785, 0.5568628, 0.13725491, 1}
@(rodata)
Color_ORANGE : Color= {1, 0.64705884, 0, 1}
@(rodata)
Color_ORANGE_RED : Color= {1, 0.27058825, 0, 1}
@(rodata)
Color_ORCHID : Color= {0.85490197, 0.4392157, 0.8392157, 1}
@(rodata)
Color_PALE_GOLDENROD : Color= {0.93333334, 0.9098039, 0.6666667, 1}
@(rodata)
Color_PALE_GREEN : Color= {0.59607846, 0.9843137, 0.59607846, 1}
@(rodata)
Color_PALE_TURQUOISE : Color= {0.6862745, 0.93333334, 0.93333334, 1}
@(rodata)
Color_PALE_VIOLET_RED : Color= {0.85882354, 0.4392157, 0.5764706, 1}
@(rodata)
Color_PAPAYA_WHIP : Color= {1, 0.9372549, 0.8352941, 1}
@(rodata)
Color_PEACH_PUFF : Color= {1, 0.85490197, 0.7254902, 1}
@(rodata)
Color_PERU : Color= {0.8039216, 0.52156866, 0.24705882, 1}
@(rodata)
Color_PINK : Color= {1, 0.7529412, 0.79607844, 1}
@(rodata)
Color_PLUM : Color= {0.8666667, 0.627451, 0.8666667, 1}
@(rodata)
Color_POWDER_BLUE : Color= {0.6901961, 0.8784314, 0.9019608, 1}
@(rodata)
Color_PURPLE : Color= {0.627451, 0.1254902, 0.9411765, 1}
@(rodata)
Color_REBECCA_PURPLE : Color= {0.4, 0.2, 0.6, 1}
@(rodata)
Color_RED : Color= {1, 0, 0, 1}
@(rodata)
Color_ROSY_BROWN : Color= {0.7372549, 0.56078434, 0.56078434, 1}
@(rodata)
Color_ROYAL_BLUE : Color= {0.25490198, 0.4117647, 0.88235295, 1}
@(rodata)
Color_SADDLE_BROWN : Color= {0.54509807, 0.27058825, 0.07450981, 1}
@(rodata)
Color_SALMON : Color= {0.98039216, 0.5019608, 0.44705883, 1}
@(rodata)
Color_SANDY_BROWN : Color= {0.95686275, 0.6431373, 0.3764706, 1}
@(rodata)
Color_SEA_GREEN : Color= {0.18039216, 0.54509807, 0.34117648, 1}
@(rodata)
Color_SEASHELL : Color= {1, 0.9607843, 0.93333334, 1}
@(rodata)
Color_SIENNA : Color= {0.627451, 0.32156864, 0.1764706, 1}
@(rodata)
Color_SILVER : Color= {0.7529412, 0.7529412, 0.7529412, 1}
@(rodata)
Color_SKY_BLUE : Color= {0.5294118, 0.80784315, 0.92156863, 1}
@(rodata)
Color_SLATE_BLUE : Color= {0.41568628, 0.3529412, 0.8039216, 1}
@(rodata)
Color_SLATE_GRAY : Color= {0.4392157, 0.5019608, 0.5647059, 1}
@(rodata)
Color_SNOW : Color= {1, 0.98039216, 0.98039216, 1}
@(rodata)
Color_SPRING_GREEN : Color= {0, 1, 0.49803922, 1}
@(rodata)
Color_STEEL_BLUE : Color= {0.27450982, 0.50980395, 0.7058824, 1}
@(rodata)
Color_TAN : Color= {0.8235294, 0.7058824, 0.54901963, 1}
@(rodata)
Color_TEAL : Color= {0, 0.5019608, 0.5019608, 1}
@(rodata)
Color_THISTLE : Color= {0.84705883, 0.7490196, 0.84705883, 1}
@(rodata)
Color_TOMATO : Color= {1, 0.3882353, 0.2784314, 1}
@(rodata)
Color_TRANSPARENT : Color= {1, 1, 1, 0}
@(rodata)
Color_TURQUOISE : Color= {0.2509804, 0.8784314, 0.8156863, 1}
@(rodata)
Color_VIOLET : Color= {0.93333334, 0.50980395, 0.93333334, 1}
@(rodata)
Color_WEB_GRAY : Color= {0.5019608, 0.5019608, 0.5019608, 1}
@(rodata)
Color_WEB_GREEN : Color= {0, 0.5019608, 0, 1}
@(rodata)
Color_WEB_MAROON : Color= {0.5019608, 0, 0, 1}
@(rodata)
Color_WEB_PURPLE : Color= {0.5019608, 0, 0.5019608, 1}
@(rodata)
Color_WHEAT : Color= {0.9607843, 0.87058824, 0.7019608, 1}
@(rodata)
Color_WHITE : Color= {1, 1, 1, 1}
@(rodata)
Color_WHITE_SMOKE : Color= {0.9607843, 0.9607843, 0.9607843, 1}
@(rodata)
Color_YELLOW : Color= {1, 1, 0, 1}
@(rodata)
Color_YELLOW_GREEN : Color= {0.6039216, 0.8039216, 0.19607843, 1}
Color_Methods_list :: struct {
    Create0: proc "c" (p_base: ^Color, p_args: rawptr = nil),
    Create1: proc "c" (p_base: ^Color,  #by_ptr p_args: struct{ from: ^Color, }),
    Create2: proc "c" (p_base: ^Color,  #by_ptr p_args: struct{ from: ^Color, alpha: ^float, }),
    Create3: proc "c" (p_base: ^Color,  #by_ptr p_args: struct{ r: ^float, g: ^float, b: ^float, }),
    Create4: proc "c" (p_base: ^Color,  #by_ptr p_args: struct{ r: ^float, g: ^float, b: ^float, a: ^float, }),
    Create5: proc "c" (p_base: ^Color,  #by_ptr p_args: struct{ code: ^gdstring, }),
    Create6: proc "c" (p_base: ^Color,  #by_ptr p_args: struct{ code: ^gdstring, alpha: ^float, }),
    get_ptr: proc "c" (base: ^Variant) -> ^Color,
    IndxSetter : proc "c" (p_base: ^Color, p_index: Int, p_value: ^float),
    IndxGetter : proc "c" (p_base: ^Color, p_index: Int, r_value: ^float),
    to_argb32:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    to_abgr32:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    to_rgba32:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    to_argb64:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    to_abgr64:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    to_rgba64:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Int, p_argument_count: i64 = 0),
    to_html:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ with_alpha: ^Bool, }, r_return: ^gdstring, p_argument_count: i64 = 1),
    clamp:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ min: ^Color, max: ^Color, }, r_return: ^Color, p_argument_count: i64 = 2),
    inverted:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Color, p_argument_count: i64 = 0),
    lerp:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ to: ^Color, weight: ^float, }, r_return: ^Color, p_argument_count: i64 = 2),
    lightened:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ amount: ^float, }, r_return: ^Color, p_argument_count: i64 = 1),
    darkened:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ amount: ^float, }, r_return: ^Color, p_argument_count: i64 = 1),
    blend:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ over: ^Color, }, r_return: ^Color, p_argument_count: i64 = 1),
    get_luminance:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^float, p_argument_count: i64 = 0),
    srgb_to_linear:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Color, p_argument_count: i64 = 0),
    linear_to_srgb:  proc "c" (p_base: ^Color, p_args: rawptr = nil, r_return: ^Color, p_argument_count: i64 = 0),
    is_equal_approx:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ to: ^Color, }, r_return: ^Bool, p_argument_count: i64 = 1),
    hex:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ hex: ^Int, }, r_return: ^Color, p_argument_count: i64 = 1),
    hex64:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ hex: ^Int, }, r_return: ^Color, p_argument_count: i64 = 1),
    html:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ rgba: ^gdstring, }, r_return: ^Color, p_argument_count: i64 = 1),
    html_is_valid:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ color: ^gdstring, }, r_return: ^Bool, p_argument_count: i64 = 1),
    from_string:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ str: ^gdstring, default: ^Color, }, r_return: ^Color, p_argument_count: i64 = 2),
    from_hsv:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ h: ^float, s: ^float, v: ^float, alpha: ^float, }, r_return: ^Color, p_argument_count: i64 = 4),
    from_ok_hsl:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ h: ^float, s: ^float, l: ^float, alpha: ^float, }, r_return: ^Color, p_argument_count: i64 = 4),
    from_rgbe9995:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ rgbe: ^Int, }, r_return: ^Color, p_argument_count: i64 = 1),
    from_rgba8:  proc "c" (p_base: ^Color, #by_ptr p_args: struct{ r8: ^Int, g8: ^Int, b8: ^Int, a8: ^Int, }, r_return: ^Color, p_argument_count: i64 = 4),
    VARIANT_OP_NEGATE_: proc "c" (p_left: ^Color, p_right: rawptr = nil,  r_result: ^Color),
    VARIANT_OP_POSITIVE_: proc "c" (p_left: ^Color, p_right: rawptr = nil,  r_result: ^Color),
    VARIANT_OP_NOT_: proc "c" (p_left: ^Color, p_right: rawptr = nil,  r_result: ^Bool),
    VARIANT_OP_MULTIPLY_Int: proc "c" (p_left: ^Color, p_right: ^Int, r_result: ^Color),
    VARIANT_OP_DIVIDE_Int: proc "c" (p_left: ^Color, p_right: ^Int, r_result: ^Color),
    VARIANT_OP_MULTIPLY_float: proc "c" (p_left: ^Color, p_right: ^float, r_result: ^Color),
    VARIANT_OP_DIVIDE_float: proc "c" (p_left: ^Color, p_right: ^float, r_result: ^Color),
    VARIANT_OP_EQUAL_Color: proc "c" (p_left: ^Color, p_right: ^Color, r_result: ^Bool),
    VARIANT_OP_NOT_EQUAL_Color: proc "c" (p_left: ^Color, p_right: ^Color, r_result: ^Bool),
    VARIANT_OP_ADD_Color: proc "c" (p_left: ^Color, p_right: ^Color, r_result: ^Color),
    VARIANT_OP_SUBTRACT_Color: proc "c" (p_left: ^Color, p_right: ^Color, r_result: ^Color),
    VARIANT_OP_MULTIPLY_Color: proc "c" (p_left: ^Color, p_right: ^Color, r_result: ^Color),
    VARIANT_OP_DIVIDE_Color: proc "c" (p_left: ^Color, p_right: ^Color, r_result: ^Color),
    VARIANT_OP_IN_Dictionary: proc "c" (p_left: ^Color, p_right: ^Dictionary, r_result: ^Bool),
    VARIANT_OP_IN_Array: proc "c" (p_left: ^Color, p_right: ^Array, r_result: ^Bool),
    VARIANT_OP_IN_PackedColorArray: proc "c" (p_left: ^Color, p_right: ^PackedColorArray, r_result: ^Bool),
}
init_Color_Methods :: proc(Color_method_store: ^Color_Methods_list) {
  Color_method_store.Create0 = cast(type_of(Color_method_store.Create0))gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 0)
  Color_method_store.Create1 = cast(type_of(Color_method_store.Create1))gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 1)
  Color_method_store.Create2 = cast(type_of(Color_method_store.Create2))gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 2)
  Color_method_store.Create3 = cast(type_of(Color_method_store.Create3))gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 3)
  Color_method_store.Create4 = cast(type_of(Color_method_store.Create4))gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 4)
  Color_method_store.Create5 = cast(type_of(Color_method_store.Create5))gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 5)
  Color_method_store.Create6 = cast(type_of(Color_method_store.Create6))gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 6)
    Color_method_store.get_ptr = cast(type_of(Color_method_store.get_ptr))gdAPI.Variant_Utils.GetVariantGetInternalPtrFunc(.COLOR)
  Color_method_store.IndxGetter = cast(type_of(Color_method_store.IndxGetter))gdAPI.Variant_Utils.GetPtrIndexedGetter(.COLOR)
  Color_method_store.IndxSetter = cast(type_of(Color_method_store.IndxSetter))gdAPI.Variant_Utils.GetPtrIndexedSetter(.COLOR)
  Color_method_store.to_argb32 = cast(type_of(Color_method_store.to_argb32))Get_Builtin_Method(.COLOR, "to_argb32", 3173160232)
  Color_method_store.to_abgr32 = cast(type_of(Color_method_store.to_abgr32))Get_Builtin_Method(.COLOR, "to_abgr32", 3173160232)
  Color_method_store.to_rgba32 = cast(type_of(Color_method_store.to_rgba32))Get_Builtin_Method(.COLOR, "to_rgba32", 3173160232)
  Color_method_store.to_argb64 = cast(type_of(Color_method_store.to_argb64))Get_Builtin_Method(.COLOR, "to_argb64", 3173160232)
  Color_method_store.to_abgr64 = cast(type_of(Color_method_store.to_abgr64))Get_Builtin_Method(.COLOR, "to_abgr64", 3173160232)
  Color_method_store.to_rgba64 = cast(type_of(Color_method_store.to_rgba64))Get_Builtin_Method(.COLOR, "to_rgba64", 3173160232)
  Color_method_store.to_html = cast(type_of(Color_method_store.to_html))Get_Builtin_Method(.COLOR, "to_html", 3429816538)
  Color_method_store.clamp = cast(type_of(Color_method_store.clamp))Get_Builtin_Method(.COLOR, "clamp", 105651410)
  Color_method_store.inverted = cast(type_of(Color_method_store.inverted))Get_Builtin_Method(.COLOR, "inverted", 3334027602)
  Color_method_store.lerp = cast(type_of(Color_method_store.lerp))Get_Builtin_Method(.COLOR, "lerp", 402949615)
  Color_method_store.lightened = cast(type_of(Color_method_store.lightened))Get_Builtin_Method(.COLOR, "lightened", 1466039168)
  Color_method_store.darkened = cast(type_of(Color_method_store.darkened))Get_Builtin_Method(.COLOR, "darkened", 1466039168)
  Color_method_store.blend = cast(type_of(Color_method_store.blend))Get_Builtin_Method(.COLOR, "blend", 3803690977)
  Color_method_store.get_luminance = cast(type_of(Color_method_store.get_luminance))Get_Builtin_Method(.COLOR, "get_luminance", 466405837)
  Color_method_store.srgb_to_linear = cast(type_of(Color_method_store.srgb_to_linear))Get_Builtin_Method(.COLOR, "srgb_to_linear", 3334027602)
  Color_method_store.linear_to_srgb = cast(type_of(Color_method_store.linear_to_srgb))Get_Builtin_Method(.COLOR, "linear_to_srgb", 3334027602)
  Color_method_store.is_equal_approx = cast(type_of(Color_method_store.is_equal_approx))Get_Builtin_Method(.COLOR, "is_equal_approx", 3167426256)
  Color_method_store.hex = cast(type_of(Color_method_store.hex))Get_Builtin_Method(.COLOR, "hex", 351421375)
  Color_method_store.hex64 = cast(type_of(Color_method_store.hex64))Get_Builtin_Method(.COLOR, "hex64", 351421375)
  Color_method_store.html = cast(type_of(Color_method_store.html))Get_Builtin_Method(.COLOR, "html", 2500054655)
  Color_method_store.html_is_valid = cast(type_of(Color_method_store.html_is_valid))Get_Builtin_Method(.COLOR, "html_is_valid", 2942997125)
  Color_method_store.from_string = cast(type_of(Color_method_store.from_string))Get_Builtin_Method(.COLOR, "from_string", 3755044230)
  Color_method_store.from_hsv = cast(type_of(Color_method_store.from_hsv))Get_Builtin_Method(.COLOR, "from_hsv", 1573799446)
  Color_method_store.from_ok_hsl = cast(type_of(Color_method_store.from_ok_hsl))Get_Builtin_Method(.COLOR, "from_ok_hsl", 1573799446)
  Color_method_store.from_rgbe9995 = cast(type_of(Color_method_store.from_rgbe9995))Get_Builtin_Method(.COLOR, "from_rgbe9995", 351421375)
  Color_method_store.from_rgba8 = cast(type_of(Color_method_store.from_rgba8))Get_Builtin_Method(.COLOR, "from_rgba8", 3072934735)
  Color_method_store.VARIANT_OP_NEGATE_ = cast(type_of(Color_method_store.VARIANT_OP_NEGATE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NEGATE, .COLOR, .NIL)
  Color_method_store.VARIANT_OP_POSITIVE_ = cast(type_of(Color_method_store.VARIANT_OP_POSITIVE_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_POSITIVE, .COLOR, .NIL)
  Color_method_store.VARIANT_OP_NOT_ = cast(type_of(Color_method_store.VARIANT_OP_NOT_))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .COLOR, .NIL)
  Color_method_store.VARIANT_OP_MULTIPLY_Int = cast(type_of(Color_method_store.VARIANT_OP_MULTIPLY_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .COLOR, .INT)
  Color_method_store.VARIANT_OP_DIVIDE_Int = cast(type_of(Color_method_store.VARIANT_OP_DIVIDE_Int))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .COLOR, .INT)
  Color_method_store.VARIANT_OP_MULTIPLY_float = cast(type_of(Color_method_store.VARIANT_OP_MULTIPLY_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .COLOR, .FLOAT)
  Color_method_store.VARIANT_OP_DIVIDE_float = cast(type_of(Color_method_store.VARIANT_OP_DIVIDE_float))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .COLOR, .FLOAT)
  Color_method_store.VARIANT_OP_EQUAL_Color = cast(type_of(Color_method_store.VARIANT_OP_EQUAL_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .COLOR, .COLOR)
  Color_method_store.VARIANT_OP_NOT_EQUAL_Color = cast(type_of(Color_method_store.VARIANT_OP_NOT_EQUAL_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .COLOR, .COLOR)
  Color_method_store.VARIANT_OP_ADD_Color = cast(type_of(Color_method_store.VARIANT_OP_ADD_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .COLOR, .COLOR)
  Color_method_store.VARIANT_OP_SUBTRACT_Color = cast(type_of(Color_method_store.VARIANT_OP_SUBTRACT_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_SUBTRACT, .COLOR, .COLOR)
  Color_method_store.VARIANT_OP_MULTIPLY_Color = cast(type_of(Color_method_store.VARIANT_OP_MULTIPLY_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_MULTIPLY, .COLOR, .COLOR)
  Color_method_store.VARIANT_OP_DIVIDE_Color = cast(type_of(Color_method_store.VARIANT_OP_DIVIDE_Color))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_DIVIDE, .COLOR, .COLOR)
  Color_method_store.VARIANT_OP_IN_Dictionary = cast(type_of(Color_method_store.VARIANT_OP_IN_Dictionary))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .COLOR, .DICTIONARY)
  Color_method_store.VARIANT_OP_IN_Array = cast(type_of(Color_method_store.VARIANT_OP_IN_Array))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .COLOR, .ARRAY)
  Color_method_store.VARIANT_OP_IN_PackedColorArray = cast(type_of(Color_method_store.VARIANT_OP_IN_PackedColorArray))gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .COLOR, .PACKED_COLOR_ARRAY)
}
