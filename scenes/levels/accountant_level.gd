extends Node2D
@onready var player: CharacterBody2D = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_checkpoint_at(global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
