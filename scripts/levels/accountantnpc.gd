extends Area2D

@onready var sprite: Sprite2D = $NPCSprite
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
@onready var level_complete: AudioStreamPlayer = $LevelComplete
@onready var record_scratch: AudioStreamPlayer = $"../RecordScratch"
@onready var chugchug: AudioStreamPlayer = $"../Chugchug"
@onready var corporate_music: AudioStreamPlayer = $"../CorporateMusic"
@onready var player: CharacterBody2D = $"../Player"

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
	
	if (won):
		player.set_money_emit(false)
		corporate_music.stop()
		record_scratch.play()
		await record_scratch.finished
		chugchug.play()
		label.text = "I can be so silly now!\n\nsilly up!"
		animation.play("recruited")
		await get_tree().create_timer(2).timeout
		label.text = "My music, not corpo slop!!"
		animation.play("recruited")
		await get_tree().create_timer(7).timeout
		get_tree().change_scene_to_file("res://scenes/game/wheel.tscn")
	

func set_text(text):
	label.text = text 
	
func set_won(didWin):
	won = didWin


func _on_accountant_level_password_right() -> void:
	won = true
	label.text = "Wow! I can play \nfornite again!"
	
