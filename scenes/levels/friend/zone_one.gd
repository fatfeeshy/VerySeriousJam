extends Area2D
@onready var player: CharacterBody2D = $"../../Player"
@onready var friend_level: Node2D = $"../.."


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and friend_level.wind_on:
		player.propeller_hat_jump_is_on = true
		player.update_jump_settings()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.propeller_hat_jump_is_on = false
		player.update_jump_settings()
