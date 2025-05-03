extends Node3D

func _ready():
	# Wait one frame so every Star Shard has entered the scene tree
	await get_tree().process_frame         

	# 1) Count how many shards are present
	GameState.total_shards = get_tree().get_nodes_in_group("star_shards").size()
	
	# 2) Reset the player’s progress for this level
	GameState.shards_collected = 0
