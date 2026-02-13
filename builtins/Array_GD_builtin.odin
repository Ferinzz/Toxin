package builtins
        
import GDW "shared:GDWrapper"
import "shared:GDWrapper/gdAPI"
import GDE "shared:GDWrapper/gdAPI/gdextension"


Array_Methods_list :: struct {
  Create0: GDE.PtrConstructor,
  Create1: GDE.PtrConstructor,
  Create2: GDE.PtrConstructor,
  Create3: GDE.PtrConstructor,
  Create4: GDE.PtrConstructor,
  Create5: GDE.PtrConstructor,
  Create6: GDE.PtrConstructor,
  Create7: GDE.PtrConstructor,
  Create8: GDE.PtrConstructor,
  Create9: GDE.PtrConstructor,
  Create10: GDE.PtrConstructor,
  Create11: GDE.PtrConstructor,
  Create12: GDE.PtrConstructor,
  Destroy: GDE.PtrDestructor,
  size:  GDE.PtrBuiltInMethod,
  is_empty:  GDE.PtrBuiltInMethod,
  clear:  GDE.PtrBuiltInMethod,
  hash:  GDE.PtrBuiltInMethod,
  assign:  GDE.PtrBuiltInMethod,
  get:  GDE.PtrBuiltInMethod,
  set:  GDE.PtrBuiltInMethod,
  push_back:  GDE.PtrBuiltInMethod,
  push_front:  GDE.PtrBuiltInMethod,
  append:  GDE.PtrBuiltInMethod,
  append_array:  GDE.PtrBuiltInMethod,
  resize:  GDE.PtrBuiltInMethod,
  insert:  GDE.PtrBuiltInMethod,
  remove_at:  GDE.PtrBuiltInMethod,
  fill:  GDE.PtrBuiltInMethod,
  erase:  GDE.PtrBuiltInMethod,
  front:  GDE.PtrBuiltInMethod,
  back:  GDE.PtrBuiltInMethod,
  pick_random:  GDE.PtrBuiltInMethod,
  find:  GDE.PtrBuiltInMethod,
  find_custom:  GDE.PtrBuiltInMethod,
  rfind:  GDE.PtrBuiltInMethod,
  rfind_custom:  GDE.PtrBuiltInMethod,
  count:  GDE.PtrBuiltInMethod,
  has:  GDE.PtrBuiltInMethod,
  pop_back:  GDE.PtrBuiltInMethod,
  pop_front:  GDE.PtrBuiltInMethod,
  pop_at:  GDE.PtrBuiltInMethod,
  sort:  GDE.PtrBuiltInMethod,
  sort_custom:  GDE.PtrBuiltInMethod,
  shuffle:  GDE.PtrBuiltInMethod,
  bsearch:  GDE.PtrBuiltInMethod,
  bsearch_custom:  GDE.PtrBuiltInMethod,
  reverse:  GDE.PtrBuiltInMethod,
  duplicate:  GDE.PtrBuiltInMethod,
  duplicate_deep:  GDE.PtrBuiltInMethod,
  slice:  GDE.PtrBuiltInMethod,
  filter:  GDE.PtrBuiltInMethod,
  gdmap:  GDE.PtrBuiltInMethod,
  reduce:  GDE.PtrBuiltInMethod,
  gdany:  GDE.PtrBuiltInMethod,
  all:  GDE.PtrBuiltInMethod,
  max:  GDE.PtrBuiltInMethod,
  min:  GDE.PtrBuiltInMethod,
  is_typed:  GDE.PtrBuiltInMethod,
  is_same_typed:  GDE.PtrBuiltInMethod,
  get_typed_builtin:  GDE.PtrBuiltInMethod,
  get_typed_class_name:  GDE.PtrBuiltInMethod,
  get_typed_script:  GDE.PtrBuiltInMethod,
  make_read_only:  GDE.PtrBuiltInMethod,
  is_read_only:  GDE.PtrBuiltInMethod,
  VARIANT_OP_NOT_: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Dictionary: GDE.PtrOperatorEvaluator,
  VARIANT_OP_EQUAL_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_NOT_EQUAL_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_LESS_EQUAL_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_GREATER_EQUAL_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_ADD_Array: GDE.PtrOperatorEvaluator,
  VARIANT_OP_IN_Array: GDE.PtrOperatorEvaluator,
}
init_Array_Methods :: proc(Array_method_store: ^Array_Methods_list) {
  Array_method_store.Create0 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 0)
  Array_method_store.Create1 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 1)
  Array_method_store.Create2 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 2)
  Array_method_store.Create3 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 3)
  Array_method_store.Create4 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 4)
  Array_method_store.Create5 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 5)
  Array_method_store.Create6 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 6)
  Array_method_store.Create7 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 7)
  Array_method_store.Create8 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 8)
  Array_method_store.Create9 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 9)
  Array_method_store.Create10 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 10)
  Array_method_store.Create11 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 11)
  Array_method_store.Create12 = gdAPI.Variant_Utils.GetPtrConstructor(.ARRAY, 12)
  Array_method_store.Destroy = gdAPI.Variant_Utils.GetPtrDestructor(.ARRAY)
  Array_method_store.size = GDW.Get_Builtin_Method(.ARRAY, "size", 3173160232)
  Array_method_store.is_empty = GDW.Get_Builtin_Method(.ARRAY, "is_empty", 3918633141)
  Array_method_store.clear = GDW.Get_Builtin_Method(.ARRAY, "clear", 3218959716)
  Array_method_store.hash = GDW.Get_Builtin_Method(.ARRAY, "hash", 3173160232)
  Array_method_store.assign = GDW.Get_Builtin_Method(.ARRAY, "assign", 2307260970)
  Array_method_store.get = GDW.Get_Builtin_Method(.ARRAY, "get", 708700221)
  Array_method_store.set = GDW.Get_Builtin_Method(.ARRAY, "set", 3798478031)
  Array_method_store.push_back = GDW.Get_Builtin_Method(.ARRAY, "push_back", 3316032543)
  Array_method_store.push_front = GDW.Get_Builtin_Method(.ARRAY, "push_front", 3316032543)
  Array_method_store.append = GDW.Get_Builtin_Method(.ARRAY, "append", 3316032543)
  Array_method_store.append_array = GDW.Get_Builtin_Method(.ARRAY, "append_array", 2307260970)
  Array_method_store.resize = GDW.Get_Builtin_Method(.ARRAY, "resize", 848867239)
  Array_method_store.insert = GDW.Get_Builtin_Method(.ARRAY, "insert", 3176316662)
  Array_method_store.remove_at = GDW.Get_Builtin_Method(.ARRAY, "remove_at", 2823966027)
  Array_method_store.fill = GDW.Get_Builtin_Method(.ARRAY, "fill", 3316032543)
  Array_method_store.erase = GDW.Get_Builtin_Method(.ARRAY, "erase", 3316032543)
  Array_method_store.front = GDW.Get_Builtin_Method(.ARRAY, "front", 1460142086)
  Array_method_store.back = GDW.Get_Builtin_Method(.ARRAY, "back", 1460142086)
  Array_method_store.pick_random = GDW.Get_Builtin_Method(.ARRAY, "pick_random", 1460142086)
  Array_method_store.find = GDW.Get_Builtin_Method(.ARRAY, "find", 2336346817)
  Array_method_store.find_custom = GDW.Get_Builtin_Method(.ARRAY, "find_custom", 2145562546)
  Array_method_store.rfind = GDW.Get_Builtin_Method(.ARRAY, "rfind", 2336346817)
  Array_method_store.rfind_custom = GDW.Get_Builtin_Method(.ARRAY, "rfind_custom", 2145562546)
  Array_method_store.count = GDW.Get_Builtin_Method(.ARRAY, "count", 1481661226)
  Array_method_store.has = GDW.Get_Builtin_Method(.ARRAY, "has", 3680194679)
  Array_method_store.pop_back = GDW.Get_Builtin_Method(.ARRAY, "pop_back", 1321915136)
  Array_method_store.pop_front = GDW.Get_Builtin_Method(.ARRAY, "pop_front", 1321915136)
  Array_method_store.pop_at = GDW.Get_Builtin_Method(.ARRAY, "pop_at", 3518259424)
  Array_method_store.sort = GDW.Get_Builtin_Method(.ARRAY, "sort", 3218959716)
  Array_method_store.sort_custom = GDW.Get_Builtin_Method(.ARRAY, "sort_custom", 3470848906)
  Array_method_store.shuffle = GDW.Get_Builtin_Method(.ARRAY, "shuffle", 3218959716)
  Array_method_store.bsearch = GDW.Get_Builtin_Method(.ARRAY, "bsearch", 3372222236)
  Array_method_store.bsearch_custom = GDW.Get_Builtin_Method(.ARRAY, "bsearch_custom", 161317131)
  Array_method_store.reverse = GDW.Get_Builtin_Method(.ARRAY, "reverse", 3218959716)
  Array_method_store.duplicate = GDW.Get_Builtin_Method(.ARRAY, "duplicate", 636440122)
  Array_method_store.duplicate_deep = GDW.Get_Builtin_Method(.ARRAY, "duplicate_deep", 1949240801)
  Array_method_store.slice = GDW.Get_Builtin_Method(.ARRAY, "slice", 1393718243)
  Array_method_store.filter = GDW.Get_Builtin_Method(.ARRAY, "filter", 4075186556)
  Array_method_store.gdmap = GDW.Get_Builtin_Method(.ARRAY, "gdmap", 4075186556)
  Array_method_store.reduce = GDW.Get_Builtin_Method(.ARRAY, "reduce", 4272450342)
  Array_method_store.gdany = GDW.Get_Builtin_Method(.ARRAY, "gdany", 4129521963)
  Array_method_store.all = GDW.Get_Builtin_Method(.ARRAY, "all", 4129521963)
  Array_method_store.max = GDW.Get_Builtin_Method(.ARRAY, "max", 1460142086)
  Array_method_store.min = GDW.Get_Builtin_Method(.ARRAY, "min", 1460142086)
  Array_method_store.is_typed = GDW.Get_Builtin_Method(.ARRAY, "is_typed", 3918633141)
  Array_method_store.is_same_typed = GDW.Get_Builtin_Method(.ARRAY, "is_same_typed", 2988181878)
  Array_method_store.get_typed_builtin = GDW.Get_Builtin_Method(.ARRAY, "get_typed_builtin", 3173160232)
  Array_method_store.get_typed_class_name = GDW.Get_Builtin_Method(.ARRAY, "get_typed_class_name", 1825232092)
  Array_method_store.get_typed_script = GDW.Get_Builtin_Method(.ARRAY, "get_typed_script", 1460142086)
  Array_method_store.make_read_only = GDW.Get_Builtin_Method(.ARRAY, "make_read_only", 3218959716)
  Array_method_store.is_read_only = GDW.Get_Builtin_Method(.ARRAY, "is_read_only", 3918633141)
  Array_method_store.VARIANT_OP_NOT_ = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT, .ARRAY, .NIL)
  Array_method_store.VARIANT_OP_IN_Dictionary = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .ARRAY, .DICTIONARY)
  Array_method_store.VARIANT_OP_EQUAL_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_NOT_EQUAL_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_NOT_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_LESS_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_LESS_EQUAL_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_LESS_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_GREATER_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_GREATER_EQUAL_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_GREATER_EQUAL, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_ADD_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_ADD, .ARRAY, .ARRAY)
  Array_method_store.VARIANT_OP_IN_Array = gdAPI.Variant_Utils.GetPtrOperatorEvaluator(.VARIANT_OP_IN, .ARRAY, .ARRAY)
}
