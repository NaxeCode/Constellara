extends Node
var total_shards   : int = 0         # placed in current level
var shards_collected : int = 0

func add_shard():
	shards_collected += 1
