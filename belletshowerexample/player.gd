extends Player

func _on_body_shape_entered(_body_id: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	# Player got touched by a bullet so sprite changes to sad face.
	#touching += 1
	print("entered")

func _on_body_shape_exited(_body_id: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	print("exit")
