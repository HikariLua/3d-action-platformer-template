class_name MotionComponent
extends Node


@export_group(ExportGroups.ATRIBUTES)
@export var max_speed: float = 92 


static func get_input_direction() -> Vector2:
	assert(InputMap.has_action(InputActions.MOVE_RIGHT))
	assert(InputMap.has_action(InputActions.MOVE_LEFT))
	assert(InputMap.has_action(InputActions.MOVE_UP))
	assert(InputMap.has_action(InputActions.MOVE_DOWN))
	
	var input: Dictionary[String, bool] = {
		"right": Input.is_action_pressed(InputActions.MOVE_RIGHT),
		"left": Input.is_action_pressed(InputActions.MOVE_LEFT),
		"up": Input.is_action_pressed(InputActions.MOVE_UP),
		"down": Input.is_action_pressed(InputActions.MOVE_DOWN)
	}
	
	if input["right"] and input["up"]:
		return Vector2(1, -1)
	elif input["left"] and input["up"]:
		return Vector2(-1, -1)
	elif input["right"] and input["down"]:
		return Vector2(1, 1)
	elif input["left"] and input["down"]:
		return Vector2(-1, 1)
	elif input["right"]:
		return Vector2.RIGHT
	elif input["up"]:
		return Vector2.UP
	elif input["left"]:
		return Vector2.LEFT
	elif input["down"]:
		return Vector2.DOWN
	
	return Vector2.ZERO


static func get_motion_direction(velocity: Vector2) -> Vector2:
	var input_direction: Vector2 = get_input_direction()
	
	if is_moving_diagonaly(velocity):
		return input_direction.normalized()
	
	return input_direction


static func is_moving_diagonaly(velocity: Vector2) -> bool:
	if velocity.x != 0 and velocity.y != 0:
		return true
	
	return false


static func move(direction: Vector2, speed: float) -> Vector2:
	return direction * speed
