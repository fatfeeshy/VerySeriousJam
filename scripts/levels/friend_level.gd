extends Node2D

@onready var player: CharacterBody2D = $Player

func _ready() -> void:
	pass


func _on_zone_one_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.propeller_hat_jump_is_on = true
		player.update_jump_settings()


func _on_zone_one_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.propeller_hat_jump_is_on = false
		player.update_jump_settings()
