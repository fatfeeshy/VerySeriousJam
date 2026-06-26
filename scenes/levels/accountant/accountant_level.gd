extends Node2D
@onready var player: CharacterBody2D = $Player
@export var password_right = false
@export var p1 = -1
@export var p2 = -1
@export var p3 = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_checkpoint_at(global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	pass # Replace with function body.
