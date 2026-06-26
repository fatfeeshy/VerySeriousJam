extends Node2D
@onready var player: CharacterBody2D = $Player

signal password_right
const p1 = 5
const p2 = 8
const p3 = 3
@onready var accountant: Area2D = $Accountant

@onready var button_p_1: Area2D = $Password/ButtonP1
@onready var button_p_2: Area2D = $Password/ButtonP2
@onready var button_p_3: Area2D = $Password/ButtonP3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_checkpoint_at(global_position)
	accountant.set_text("OMG your here to give me\nmy fortnite password?\nmake sure to get it right\nwith the buttons")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (button_p_1.get_value() == p1 and button_p_2.get_value() == p2 and button_p_3.get_value() == p3):
		password_right.emit()
