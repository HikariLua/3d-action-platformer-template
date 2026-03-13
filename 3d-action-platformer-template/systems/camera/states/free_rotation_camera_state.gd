class_name FreeRotationCameraState
extends State

@export var input_component: InputComponent
@export var camera_controller: Camera3DController

var input: InputData


func _ready() -> void:
	assert(input_component != null)
	assert(input_component.data != null)
	assert(camera_controller != null)

	input = input_component.data


func _state_input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return

	var mouse_motion: InputEventMouseMotion = event as InputEventMouseMotion

	# TODO: make proper invert logic when get the singleton settings

	var x_rotation: float = mouse_motion.relative.y * input.camera_mouse_sensitivity
	var y_rotation: float = mouse_motion.relative.x * input.camera_mouse_sensitivity

	camera_controller.rotation.x += deg_to_rad(x_rotation * -1)
	camera_controller.rotation.y += deg_to_rad(y_rotation * -1)


func _on_enter() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _state_physics_process(delta: float) -> void:
	var input_direction: Vector2 = InputComponent.get_camera_input_direction()

	if input_direction == Vector2.ZERO:
		return

	var y_rotation: float = input_direction.x * input.camera_sensitivity * delta
	var x_rotation: float = input_direction.y * input.camera_sensitivity * delta

	camera_controller.rotation.x += deg_to_rad(x_rotation)
	camera_controller.rotation.y += deg_to_rad(y_rotation)


func _on_exit() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
