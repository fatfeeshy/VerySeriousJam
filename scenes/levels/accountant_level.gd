extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var checkpoint_1: Area2D = $Checkpoints/Checkpoint


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_checkpoint_at(checkpoint_1.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
