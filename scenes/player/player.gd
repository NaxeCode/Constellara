extends CharacterBody3D

@export var speed:float = 8.0
@export var jump_force:float = 6.0
@export var accel:float = 12.0
@export var friction:float = 14.0
@export var GRAVITY :float = ProjectSettings.get_setting("physics/3d/default_gravity")
const KILL_PLANE_Y := -20.0

func _physics_process(delta: float) -> void:
	#1) Read WASD movement as vector2 (-1 .. 1 on each axis)
	var input_2d = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	#2) Convert to world-space based on the player's orientation
	var cam_basis = $Pivot.global_transform.basis  # path to your Pivot
	var direction = (cam_basis * Vector3(input_2d.x, 0, input_2d.y)).normalized()
	direction.y = 0               # flatten (camera is tilted)
	direction = direction.normalized()

	
	#3) Horizontal velocity blend (accel / friction)
	if direction.length() > 0.01:
		velocity.x = lerp(velocity.x, direction.x * speed, accel * delta)
		velocity.z = lerp(velocity.z, direction.z * speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)
	
	#4) Jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	
	#5) Apply Gravity (Looks like Godot's CharacterBody3D doesn't auto-apply it)
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	
	move_and_slide()
	
	if global_transform.origin.y < KILL_PLANE_Y:
		Respawn.respawn_player(self)
