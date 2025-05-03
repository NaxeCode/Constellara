extends Area3D
class_name Checkpoint

@export var pad_color : Color = Color(0.3, 0.9, 1.0)

signal activated(checkpoint : Checkpoint)

func _ready():
	$MeshInstance3D.material_override.albedo_color = pad_color
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("activated", self)
