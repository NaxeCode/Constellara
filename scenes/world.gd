extends Node3D
# preload hud scene
@onready var hud_scene := preload("res://ui/hud.tscn")

func _ready():
	# connect every checkpoint to the singleton once
	for cp in get_tree().get_nodes_in_group("checkpoints"):
		cp.connect("activated", _on_checkpoint_activated)
	# Add HUD
	add_child(hud_scene.instantiate())
	
	await get_tree().process_frame         # let shards add themselves to the group
	GameState.total_shards      = get_tree().get_nodes_in_group("star_shards").size()
	GameState.shards_collected  = 0

func _on_checkpoint_activated(cp):
	Respawn.set_checkpoint(cp)
