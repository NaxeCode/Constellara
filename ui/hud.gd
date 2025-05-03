extends CanvasLayer

@onready var bar   : TextureProgressBar = $MarginContainer/TextureProgressBar
@onready var anim  : AnimationPlayer    = $AnimationPlayer    # <-- the node you added

func _ready():
	bar.value = 0
	for shard in get_tree().get_nodes_in_group("star_shards"):
		shard.connect("collected", _on_shard_collected)

func _on_shard_collected() -> void:
	GameState.add_shard()
	bar.value = float(GameState.shards_collected) / GameState.total_shards * 100.0
	anim.play("Pulse")                 # <‑‑ this is where $AnimationPlayer.play("Pulse") goes
