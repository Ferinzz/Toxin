package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Color_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  Create5: GDE.PtrConstructor,
  Create6: GDE.PtrConstructor,
  to_argb32:  GDE.PtrBuiltInMethod,
  to_abgr32:  GDE.PtrBuiltInMethod,
  to_rgba32:  GDE.PtrBuiltInMethod,
  to_argb64:  GDE.PtrBuiltInMethod,
  to_abgr64:  GDE.PtrBuiltInMethod,
  to_rgba64:  GDE.PtrBuiltInMethod,
  to_html:  GDE.PtrBuiltInMethod,
  clamp:  GDE.PtrBuiltInMethod,
  inverted:  GDE.PtrBuiltInMethod,
  lerp:  GDE.PtrBuiltInMethod,
  lightened:  GDE.PtrBuiltInMethod,
  darkened:  GDE.PtrBuiltInMethod,
  blend:  GDE.PtrBuiltInMethod,
  get_luminance:  GDE.PtrBuiltInMethod,
  srgb_to_linear:  GDE.PtrBuiltInMethod,
  linear_to_srgb:  GDE.PtrBuiltInMethod,
  is_equal_approx:  GDE.PtrBuiltInMethod,
  hex:  GDE.PtrBuiltInMethod,
  hex64:  GDE.PtrBuiltInMethod,
  html:  GDE.PtrBuiltInMethod,
  html_is_valid:  GDE.PtrBuiltInMethod,
  from_string:  GDE.PtrBuiltInMethod,
  from_hsv:  GDE.PtrBuiltInMethod,
  from_ok_hsl:  GDE.PtrBuiltInMethod,
  from_rgbe9995:  GDE.PtrBuiltInMethod,
  from_rgba8:  GDE.PtrBuiltInMethod,
}
@(rodata)
Color_ALICE_BLUE :GDW.Color= {0.9411765, 0.972549, 1, 1}
@(rodata)
Color_ANTIQUE_WHITE :GDW.Color= {0.98039216, 0.92156863, 0.84313726, 1}
@(rodata)
Color_AQUA :GDW.Color= {0, 1, 1, 1}
@(rodata)
Color_AQUAMARINE :GDW.Color= {0.49803922, 1, 0.83137256, 1}
@(rodata)
Color_AZURE :GDW.Color= {0.9411765, 1, 1, 1}
@(rodata)
Color_BEIGE :GDW.Color= {0.9607843, 0.9607843, 0.8627451, 1}
@(rodata)
Color_BISQUE :GDW.Color= {1, 0.89411765, 0.76862746, 1}
@(rodata)
Color_BLACK :GDW.Color= {0, 0, 0, 1}
@(rodata)
Color_BLANCHED_ALMOND :GDW.Color= {1, 0.92156863, 0.8039216, 1}
@(rodata)
Color_BLUE :GDW.Color= {0, 0, 1, 1}
@(rodata)
Color_BLUE_VIOLET :GDW.Color= {0.5411765, 0.16862746, 0.8862745, 1}
@(rodata)
Color_BROWN :GDW.Color= {0.64705884, 0.16470589, 0.16470589, 1}
@(rodata)
Color_BURLYWOOD :GDW.Color= {0.87058824, 0.72156864, 0.5294118, 1}
@(rodata)
Color_CADET_BLUE :GDW.Color= {0.37254903, 0.61960787, 0.627451, 1}
@(rodata)
Color_CHARTREUSE :GDW.Color= {0.49803922, 1, 0, 1}
@(rodata)
Color_CHOCOLATE :GDW.Color= {0.8235294, 0.4117647, 0.11764706, 1}
@(rodata)
Color_CORAL :GDW.Color= {1, 0.49803922, 0.3137255, 1}
@(rodata)
Color_CORNFLOWER_BLUE :GDW.Color= {0.39215687, 0.58431375, 0.92941177, 1}
@(rodata)
Color_CORNSILK :GDW.Color= {1, 0.972549, 0.8627451, 1}
@(rodata)
Color_CRIMSON :GDW.Color= {0.8627451, 0.078431375, 0.23529412, 1}
@(rodata)
Color_CYAN :GDW.Color= {0, 1, 1, 1}
@(rodata)
Color_DARK_BLUE :GDW.Color= {0, 0, 0.54509807, 1}
@(rodata)
Color_DARK_CYAN :GDW.Color= {0, 0.54509807, 0.54509807, 1}
@(rodata)
Color_DARK_GOLDENROD :GDW.Color= {0.72156864, 0.5254902, 0.043137256, 1}
@(rodata)
Color_DARK_GRAY :GDW.Color= {0.6627451, 0.6627451, 0.6627451, 1}
@(rodata)
Color_DARK_GREEN :GDW.Color= {0, 0.39215687, 0, 1}
@(rodata)
Color_DARK_KHAKI :GDW.Color= {0.7411765, 0.7176471, 0.41960785, 1}
@(rodata)
Color_DARK_MAGENTA :GDW.Color= {0.54509807, 0, 0.54509807, 1}
@(rodata)
Color_DARK_OLIVE_GREEN :GDW.Color= {0.33333334, 0.41960785, 0.18431373, 1}
@(rodata)
Color_DARK_ORANGE :GDW.Color= {1, 0.54901963, 0, 1}
@(rodata)
Color_DARK_ORCHID :GDW.Color= {0.6, 0.19607843, 0.8, 1}
@(rodata)
Color_DARK_RED :GDW.Color= {0.54509807, 0, 0, 1}
@(rodata)
Color_DARK_SALMON :GDW.Color= {0.9137255, 0.5882353, 0.47843137, 1}
@(rodata)
Color_DARK_SEA_GREEN :GDW.Color= {0.56078434, 0.7372549, 0.56078434, 1}
@(rodata)
Color_DARK_SLATE_BLUE :GDW.Color= {0.28235295, 0.23921569, 0.54509807, 1}
@(rodata)
Color_DARK_SLATE_GRAY :GDW.Color= {0.18431373, 0.30980393, 0.30980393, 1}
@(rodata)
Color_DARK_TURQUOISE :GDW.Color= {0, 0.80784315, 0.81960785, 1}
@(rodata)
Color_DARK_VIOLET :GDW.Color= {0.5803922, 0, 0.827451, 1}
@(rodata)
Color_DEEP_PINK :GDW.Color= {1, 0.078431375, 0.5764706, 1}
@(rodata)
Color_DEEP_SKY_BLUE :GDW.Color= {0, 0.7490196, 1, 1}
@(rodata)
Color_DIM_GRAY :GDW.Color= {0.4117647, 0.4117647, 0.4117647, 1}
@(rodata)
Color_DODGER_BLUE :GDW.Color= {0.11764706, 0.5647059, 1, 1}
@(rodata)
Color_FIREBRICK :GDW.Color= {0.69803923, 0.13333334, 0.13333334, 1}
@(rodata)
Color_FLORAL_WHITE :GDW.Color= {1, 0.98039216, 0.9411765, 1}
@(rodata)
Color_FOREST_GREEN :GDW.Color= {0.13333334, 0.54509807, 0.13333334, 1}
@(rodata)
Color_FUCHSIA :GDW.Color= {1, 0, 1, 1}
@(rodata)
Color_GAINSBORO :GDW.Color= {0.8627451, 0.8627451, 0.8627451, 1}
@(rodata)
Color_GHOST_WHITE :GDW.Color= {0.972549, 0.972549, 1, 1}
@(rodata)
Color_GOLD :GDW.Color= {1, 0.84313726, 0, 1}
@(rodata)
Color_GOLDENROD :GDW.Color= {0.85490197, 0.64705884, 0.1254902, 1}
@(rodata)
Color_GRAY :GDW.Color= {0.74509805, 0.74509805, 0.74509805, 1}
@(rodata)
Color_GREEN :GDW.Color= {0, 1, 0, 1}
@(rodata)
Color_GREEN_YELLOW :GDW.Color= {0.6784314, 1, 0.18431373, 1}
@(rodata)
Color_HONEYDEW :GDW.Color= {0.9411765, 1, 0.9411765, 1}
@(rodata)
Color_HOT_PINK :GDW.Color= {1, 0.4117647, 0.7058824, 1}
@(rodata)
Color_INDIAN_RED :GDW.Color= {0.8039216, 0.36078432, 0.36078432, 1}
@(rodata)
Color_INDIGO :GDW.Color= {0.29411766, 0, 0.50980395, 1}
@(rodata)
Color_IVORY :GDW.Color= {1, 1, 0.9411765, 1}
@(rodata)
Color_KHAKI :GDW.Color= {0.9411765, 0.9019608, 0.54901963, 1}
@(rodata)
Color_LAVENDER :GDW.Color= {0.9019608, 0.9019608, 0.98039216, 1}
@(rodata)
Color_LAVENDER_BLUSH :GDW.Color= {1, 0.9411765, 0.9607843, 1}
@(rodata)
Color_LAWN_GREEN :GDW.Color= {0.4862745, 0.9882353, 0, 1}
@(rodata)
Color_LEMON_CHIFFON :GDW.Color= {1, 0.98039216, 0.8039216, 1}
@(rodata)
Color_LIGHT_BLUE :GDW.Color= {0.6784314, 0.84705883, 0.9019608, 1}
@(rodata)
Color_LIGHT_CORAL :GDW.Color= {0.9411765, 0.5019608, 0.5019608, 1}
@(rodata)
Color_LIGHT_CYAN :GDW.Color= {0.8784314, 1, 1, 1}
@(rodata)
Color_LIGHT_GOLDENROD :GDW.Color= {0.98039216, 0.98039216, 0.8235294, 1}
@(rodata)
Color_LIGHT_GRAY :GDW.Color= {0.827451, 0.827451, 0.827451, 1}
@(rodata)
Color_LIGHT_GREEN :GDW.Color= {0.5647059, 0.93333334, 0.5647059, 1}
@(rodata)
Color_LIGHT_PINK :GDW.Color= {1, 0.7137255, 0.75686276, 1}
@(rodata)
Color_LIGHT_SALMON :GDW.Color= {1, 0.627451, 0.47843137, 1}
@(rodata)
Color_LIGHT_SEA_GREEN :GDW.Color= {0.1254902, 0.69803923, 0.6666667, 1}
@(rodata)
Color_LIGHT_SKY_BLUE :GDW.Color= {0.5294118, 0.80784315, 0.98039216, 1}
@(rodata)
Color_LIGHT_SLATE_GRAY :GDW.Color= {0.46666667, 0.53333336, 0.6, 1}
@(rodata)
Color_LIGHT_STEEL_BLUE :GDW.Color= {0.6901961, 0.76862746, 0.87058824, 1}
@(rodata)
Color_LIGHT_YELLOW :GDW.Color= {1, 1, 0.8784314, 1}
@(rodata)
Color_LIME :GDW.Color= {0, 1, 0, 1}
@(rodata)
Color_LIME_GREEN :GDW.Color= {0.19607843, 0.8039216, 0.19607843, 1}
@(rodata)
Color_LINEN :GDW.Color= {0.98039216, 0.9411765, 0.9019608, 1}
@(rodata)
Color_MAGENTA :GDW.Color= {1, 0, 1, 1}
@(rodata)
Color_MAROON :GDW.Color= {0.6901961, 0.1882353, 0.3764706, 1}
@(rodata)
Color_MEDIUM_AQUAMARINE :GDW.Color= {0.4, 0.8039216, 0.6666667, 1}
@(rodata)
Color_MEDIUM_BLUE :GDW.Color= {0, 0, 0.8039216, 1}
@(rodata)
Color_MEDIUM_ORCHID :GDW.Color= {0.7294118, 0.33333334, 0.827451, 1}
@(rodata)
Color_MEDIUM_PURPLE :GDW.Color= {0.5764706, 0.4392157, 0.85882354, 1}
@(rodata)
Color_MEDIUM_SEA_GREEN :GDW.Color= {0.23529412, 0.7019608, 0.44313726, 1}
@(rodata)
Color_MEDIUM_SLATE_BLUE :GDW.Color= {0.48235294, 0.40784314, 0.93333334, 1}
@(rodata)
Color_MEDIUM_SPRING_GREEN :GDW.Color= {0, 0.98039216, 0.6039216, 1}
@(rodata)
Color_MEDIUM_TURQUOISE :GDW.Color= {0.28235295, 0.81960785, 0.8, 1}
@(rodata)
Color_MEDIUM_VIOLET_RED :GDW.Color= {0.78039217, 0.08235294, 0.52156866, 1}
@(rodata)
Color_MIDNIGHT_BLUE :GDW.Color= {0.09803922, 0.09803922, 0.4392157, 1}
@(rodata)
Color_MINT_CREAM :GDW.Color= {0.9607843, 1, 0.98039216, 1}
@(rodata)
Color_MISTY_ROSE :GDW.Color= {1, 0.89411765, 0.88235295, 1}
@(rodata)
Color_MOCCASIN :GDW.Color= {1, 0.89411765, 0.70980394, 1}
@(rodata)
Color_NAVAJO_WHITE :GDW.Color= {1, 0.87058824, 0.6784314, 1}
@(rodata)
Color_NAVY_BLUE :GDW.Color= {0, 0, 0.5019608, 1}
@(rodata)
Color_OLD_LACE :GDW.Color= {0.99215686, 0.9607843, 0.9019608, 1}
@(rodata)
Color_OLIVE :GDW.Color= {0.5019608, 0.5019608, 0, 1}
@(rodata)
Color_OLIVE_DRAB :GDW.Color= {0.41960785, 0.5568628, 0.13725491, 1}
@(rodata)
Color_ORANGE :GDW.Color= {1, 0.64705884, 0, 1}
@(rodata)
Color_ORANGE_RED :GDW.Color= {1, 0.27058825, 0, 1}
@(rodata)
Color_ORCHID :GDW.Color= {0.85490197, 0.4392157, 0.8392157, 1}
@(rodata)
Color_PALE_GOLDENROD :GDW.Color= {0.93333334, 0.9098039, 0.6666667, 1}
@(rodata)
Color_PALE_GREEN :GDW.Color= {0.59607846, 0.9843137, 0.59607846, 1}
@(rodata)
Color_PALE_TURQUOISE :GDW.Color= {0.6862745, 0.93333334, 0.93333334, 1}
@(rodata)
Color_PALE_VIOLET_RED :GDW.Color= {0.85882354, 0.4392157, 0.5764706, 1}
@(rodata)
Color_PAPAYA_WHIP :GDW.Color= {1, 0.9372549, 0.8352941, 1}
@(rodata)
Color_PEACH_PUFF :GDW.Color= {1, 0.85490197, 0.7254902, 1}
@(rodata)
Color_PERU :GDW.Color= {0.8039216, 0.52156866, 0.24705882, 1}
@(rodata)
Color_PINK :GDW.Color= {1, 0.7529412, 0.79607844, 1}
@(rodata)
Color_PLUM :GDW.Color= {0.8666667, 0.627451, 0.8666667, 1}
@(rodata)
Color_POWDER_BLUE :GDW.Color= {0.6901961, 0.8784314, 0.9019608, 1}
@(rodata)
Color_PURPLE :GDW.Color= {0.627451, 0.1254902, 0.9411765, 1}
@(rodata)
Color_REBECCA_PURPLE :GDW.Color= {0.4, 0.2, 0.6, 1}
@(rodata)
Color_RED :GDW.Color= {1, 0, 0, 1}
@(rodata)
Color_ROSY_BROWN :GDW.Color= {0.7372549, 0.56078434, 0.56078434, 1}
@(rodata)
Color_ROYAL_BLUE :GDW.Color= {0.25490198, 0.4117647, 0.88235295, 1}
@(rodata)
Color_SADDLE_BROWN :GDW.Color= {0.54509807, 0.27058825, 0.07450981, 1}
@(rodata)
Color_SALMON :GDW.Color= {0.98039216, 0.5019608, 0.44705883, 1}
@(rodata)
Color_SANDY_BROWN :GDW.Color= {0.95686275, 0.6431373, 0.3764706, 1}
@(rodata)
Color_SEA_GREEN :GDW.Color= {0.18039216, 0.54509807, 0.34117648, 1}
@(rodata)
Color_SEASHELL :GDW.Color= {1, 0.9607843, 0.93333334, 1}
@(rodata)
Color_SIENNA :GDW.Color= {0.627451, 0.32156864, 0.1764706, 1}
@(rodata)
Color_SILVER :GDW.Color= {0.7529412, 0.7529412, 0.7529412, 1}
@(rodata)
Color_SKY_BLUE :GDW.Color= {0.5294118, 0.80784315, 0.92156863, 1}
@(rodata)
Color_SLATE_BLUE :GDW.Color= {0.41568628, 0.3529412, 0.8039216, 1}
@(rodata)
Color_SLATE_GRAY :GDW.Color= {0.4392157, 0.5019608, 0.5647059, 1}
@(rodata)
Color_SNOW :GDW.Color= {1, 0.98039216, 0.98039216, 1}
@(rodata)
Color_SPRING_GREEN :GDW.Color= {0, 1, 0.49803922, 1}
@(rodata)
Color_STEEL_BLUE :GDW.Color= {0.27450982, 0.50980395, 0.7058824, 1}
@(rodata)
Color_TAN :GDW.Color= {0.8235294, 0.7058824, 0.54901963, 1}
@(rodata)
Color_TEAL :GDW.Color= {0, 0.5019608, 0.5019608, 1}
@(rodata)
Color_THISTLE :GDW.Color= {0.84705883, 0.7490196, 0.84705883, 1}
@(rodata)
Color_TOMATO :GDW.Color= {1, 0.3882353, 0.2784314, 1}
@(rodata)
Color_TRANSPARENT :GDW.Color= {1, 1, 1, 0}
@(rodata)
Color_TURQUOISE :GDW.Color= {0.2509804, 0.8784314, 0.8156863, 1}
@(rodata)
Color_VIOLET :GDW.Color= {0.93333334, 0.50980395, 0.93333334, 1}
@(rodata)
Color_WEB_GRAY :GDW.Color= {0.5019608, 0.5019608, 0.5019608, 1}
@(rodata)
Color_WEB_GREEN :GDW.Color= {0, 0.5019608, 0, 1}
@(rodata)
Color_WEB_MAROON :GDW.Color= {0.5019608, 0, 0, 1}
@(rodata)
Color_WEB_PURPLE :GDW.Color= {0.5019608, 0, 0.5019608, 1}
@(rodata)
Color_WHEAT :GDW.Color= {0.9607843, 0.87058824, 0.7019608, 1}
@(rodata)
Color_WHITE :GDW.Color= {1, 1, 1, 1}
@(rodata)
Color_WHITE_SMOKE :GDW.Color= {0.9607843, 0.9607843, 0.9607843, 1}
@(rodata)
Color_YELLOW :GDW.Color= {1, 1, 0, 1}
@(rodata)
Color_YELLOW_GREEN :GDW.Color= {0.6039216, 0.8039216, 0.19607843, 1}
init_Color_Methods :: proc(Color_method_store: ^Color_Methods_list) {
  Color_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 0)
  Color_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 1)
  Color_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 2)
  Color_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 3)
  Color_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 4)
  Color_method_store.Create5 = gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 5)
  Color_method_store.Create6 = gdAPI.Variant_Utils.GetPtrConstructor(.COLOR, 6)
  Color_method_store.to_argb32 = GDW.Get_Builtin_Method(.COLOR, "to_argb32", 3173160232)
  Color_method_store.to_abgr32 = GDW.Get_Builtin_Method(.COLOR, "to_abgr32", 3173160232)
  Color_method_store.to_rgba32 = GDW.Get_Builtin_Method(.COLOR, "to_rgba32", 3173160232)
  Color_method_store.to_argb64 = GDW.Get_Builtin_Method(.COLOR, "to_argb64", 3173160232)
  Color_method_store.to_abgr64 = GDW.Get_Builtin_Method(.COLOR, "to_abgr64", 3173160232)
  Color_method_store.to_rgba64 = GDW.Get_Builtin_Method(.COLOR, "to_rgba64", 3173160232)
  Color_method_store.to_html = GDW.Get_Builtin_Method(.COLOR, "to_html", 3429816538)
  Color_method_store.clamp = GDW.Get_Builtin_Method(.COLOR, "clamp", 105651410)
  Color_method_store.inverted = GDW.Get_Builtin_Method(.COLOR, "inverted", 3334027602)
  Color_method_store.lerp = GDW.Get_Builtin_Method(.COLOR, "lerp", 402949615)
  Color_method_store.lightened = GDW.Get_Builtin_Method(.COLOR, "lightened", 1466039168)
  Color_method_store.darkened = GDW.Get_Builtin_Method(.COLOR, "darkened", 1466039168)
  Color_method_store.blend = GDW.Get_Builtin_Method(.COLOR, "blend", 3803690977)
  Color_method_store.get_luminance = GDW.Get_Builtin_Method(.COLOR, "get_luminance", 466405837)
  Color_method_store.srgb_to_linear = GDW.Get_Builtin_Method(.COLOR, "srgb_to_linear", 3334027602)
  Color_method_store.linear_to_srgb = GDW.Get_Builtin_Method(.COLOR, "linear_to_srgb", 3334027602)
  Color_method_store.is_equal_approx = GDW.Get_Builtin_Method(.COLOR, "is_equal_approx", 3167426256)
  Color_method_store.hex = GDW.Get_Builtin_Method(.COLOR, "hex", 351421375)
  Color_method_store.hex64 = GDW.Get_Builtin_Method(.COLOR, "hex64", 351421375)
  Color_method_store.html = GDW.Get_Builtin_Method(.COLOR, "html", 2500054655)
  Color_method_store.html_is_valid = GDW.Get_Builtin_Method(.COLOR, "html_is_valid", 2942997125)
  Color_method_store.from_string = GDW.Get_Builtin_Method(.COLOR, "from_string", 3755044230)
  Color_method_store.from_hsv = GDW.Get_Builtin_Method(.COLOR, "from_hsv", 1573799446)
  Color_method_store.from_ok_hsl = GDW.Get_Builtin_Method(.COLOR, "from_ok_hsl", 1573799446)
  Color_method_store.from_rgbe9995 = GDW.Get_Builtin_Method(.COLOR, "from_rgbe9995", 351421375)
  Color_method_store.from_rgba8 = GDW.Get_Builtin_Method(.COLOR, "from_rgba8", 3072934735)
}
