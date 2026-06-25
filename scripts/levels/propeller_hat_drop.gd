extends Area2D
signal picked_up

@onready var player: CharacterBody2D = $Player

func _on_body_entered(body: CharacterBody2D) -> void:
	if not body is CharacterBody2D:
		return
	emit_signal("picked_up")
	queue_free()
