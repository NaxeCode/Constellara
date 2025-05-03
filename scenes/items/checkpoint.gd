extends Area3D
class_name Checkpoint

@export var pad_color : Color = Color(0.3, 0.9, 1.0)

@onready var mesh := $MeshInstance3D

signal activated(checkpoint : Checkpoint)

func _ready():
	var mat : StandardMaterial3D = mesh.material_override
	if mat == null:
		mat = StandardMaterial3D.new()
		mesh.material_override = mat
	mat.albedo_color = pad_color
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		print_debug(body.name + " Entered Checkpoint")
		emit_signal("activated", self)
