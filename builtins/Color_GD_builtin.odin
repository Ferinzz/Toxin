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
