extends Node3D
@export var mouse_sensitivity : float = 0.02
@export var stick_sensitivity : float = 90.0   # deg/sec
@export var min_pitch : float = -30.0          # look‑up clamp
@export var max_pitch : float = 45.0           # look‑down clamp
@export var recenter_speed : float = 360.0     # deg/sec when snapping

var _yaw   : float = 0.0   # around Y
var _pitch : float = 10.0  # around X  (slight downward angle)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # optional

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_yaw   -= event.relative.x * mouse_sensitivity
		_pitch -= event.relative.y * mouse_sensitivity
		_pitch = clamp(_pitch, deg_to_rad(min_pitch), deg_to_rad(max_pitch))

func _physics_process(delta: float) -> void:
	# --- gamepad look ---
	var look_vector := Vector2(
		Input.get_action_strength("look_right") - Input.get_action_strength("look_left"),
		Input.get_action_strength("look_up")    - Input.get_action_strength("look_down")
	)
	if look_vector.length() > 0.01:
		_yaw   -= look_vector.x * stick_sensitivity * delta * 0.0174533  # deg→rad
		_pitch -= look_vector.y * stick_sensitivity * delta * 0.0174533
		_pitch = clamp(_pitch, deg_to_rad(min_pitch), deg_to_rad(max_pitch))

	# --- recenter behind player (optional) ---
	if Input.is_action_just_pressed("cam_center"):
		var target_yaw = get_parent().rotation.y     # player’s facing
		_yaw = lerp_angle(_yaw, target_yaw, recenter_speed * delta * 0.0174533)

	# --- apply rotation ---
	rotation = Vector3(_pitch, _yaw, 0)
