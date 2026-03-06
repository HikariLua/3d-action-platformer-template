extends Node3D

func _ready() -> void:
	var v: Vector3 = Vector3(3, 4, 5)
	
	print(v.normalized())
	print(v.normalized().normalized())
