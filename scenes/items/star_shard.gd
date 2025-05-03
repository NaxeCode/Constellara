extends Area3D
signal collected                                 # let the world/UI know

@export var rotate_speed : float = 60.0          # deg/sec

func _ready():
	add_to_group("star_shards")
	connect("body_entered", _on_body_entered)

func _process(delta):
	rotate_y(deg_to_rad(rotate_speed * delta))    # idle spin

func _on_body_entered(body):
	if body.name == "Player":                     # any tag check works
		emit_signal("collected")
		queue_free()
