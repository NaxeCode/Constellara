extends Node

var current_checkpoint : Node3D

func set_checkpoint(cp : Node3D):
	current_checkpoint = cp

func respawn_player(player : CharacterBody3D):
	if current_checkpoint:
		player.global_transform.origin = current_checkpoint.global_transform.origin + Vector3(0, 1.2, 0)
		player.velocity = Vector3.ZERO
