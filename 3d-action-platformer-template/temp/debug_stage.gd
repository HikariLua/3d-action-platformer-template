extends Node3D
@export var static_body_3d: StaticBody3D

func _ready() -> void:
	print(visibility_changed == self.visibility_changed)
