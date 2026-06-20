extends Node2D

@onready var player: CharacterBody2D = $Player

#var right_side_border := 624

func _ready():
	#player.camera.limit_right = 624
	pass


func _on_redzone_entered(body: CharacterBody2D) -> void:
	# player is at risk
	pass

func _on_redzone_exited(body: CharacterBody2D) -> void:
	# player is no longer at risk
	pass
