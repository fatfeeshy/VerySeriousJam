extends Area2D

@onready var player: CharacterBody2D = $"../../Player"

func _on_body_entered(body: CharacterBody2D) -> void:
	player.set_checkpoint_at(global_position)
