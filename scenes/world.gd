extends Node3D
# preload hud scene
@onready var hud_scene := preload("res://ui/hud.tscn")

func _ready():
	# Add HUD
	add_child(hud_scene.instantiate())
	
	await get_tree().process_frame         # let shards add themselves to the group
	GameState.total_shards      = get_tree().get_nodes_in_group("star_shards").size()
	GameState.shards_collected  = 0
