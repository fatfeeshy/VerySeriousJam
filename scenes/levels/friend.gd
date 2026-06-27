extends Area2D

@onready var sprite: Sprite2D = $NPCSprite
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
@onready var level_complete: AudioStreamPlayer = $LevelComplete

var won = false
var friend_sprite := Rect2(0, 0, 16, 17)
var secretary_sprite := Rect2(16, 0, 16, 17)
var accountant_sprite := Rect2(32, 0, 16, 17)

func _ready() -> void:
	match get_tree().current_scene.name:
		"accountantLevel":
			sprite.flip_h = true
			sprite.region_rect = accountant_sprite
		"FriendLevel":
			sprite.region_rect = friend_sprite
		"SecretaryLevel":
			sprite.flip_h = true
			sprite.region_rect = secretary_sprite

func _on_body_entered(body: CharacterBody2D) -> void:
	animation.play("recruited")
	won = true
	globals.finishedFriend = true
	if (won):
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://scenes/game/wheel.tscn")
	

func set_text(text):
	label.text = text 
	
func set_won(didWin):
	won = didWin
