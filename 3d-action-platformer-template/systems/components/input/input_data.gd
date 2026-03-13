class_name InputData
extends Resource

enum DirectionMode {
	TWO_DIMENSIONS,
	THREE_DIMENSIONS
}


@export var direction_mode: DirectionMode = DirectionMode.THREE_DIMENSIONS
# TODO: move to actual settings singleton logic later
@export var camera_sensitivity: int = 100
@export var camera_mouse_sensitivity: float = 0.1
