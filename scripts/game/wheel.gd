extends Node2D

@onready var wheel: Sprite2D = $Wheel
@onready var display_message: Label = $DisplayMessage
@onready var spin_prize_wheel_sfx: AudioStreamPlayer = $SpinPrizeWheelSfx


var  SECTION_ANGLES = {
	"accountant": 60.0,
	"friend": 180.0,
	"secretary": 300.0,
}

func spin():
	if globals.finishedAccountant:
		SECTION_ANGLES.erase("accountant")
	if globals.finishedFriend:
		SECTION_ANGLES.erase("friend")
	if globals.finishedSecretary:
		SECTION_ANGLES.erase("secretary")
	print(SECTION_ANGLES)
	if SECTION_ANGLES.is_empty():
		print("??")
		get_tree().change_scene_to_file("res://scenes/levels/boss_level.tscn")
		return
	display_message.text = ""
	
	var result = SECTION_ANGLES.keys().pick_random()
	var full_spins = randi_range(4, 8)
	
	var offset = randf_range(-20.0, 20.0)
	print(result)
	var target_rotation = rotation_degrees + full_spins * 360 + SECTION_ANGLES[result] + offset
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		wheel,
		"rotation_degrees",
		target_rotation,
		randf_range(2.5, 4.0)
	)
	spin_prize_wheel_sfx.play()
	await tween.finished
	await get_tree().create_timer(.1).timeout
	spin_prize_wheel_sfx.stop()
	
	match result:
		"accountant":
			display_message.text = "Level accountant!"
			get_tree().change_scene_to_file("res://scenes/levels/accountant/accountant_level.tscn")
		"friend":
			display_message.text = "Level friend!"
			get_tree().change_scene_to_file("res://scenes/levels/friend/friend_level.tscn")
		"secretary":
			display_message.text = "Level secretary!"
			get_tree().change_scene_to_file("res://scenes/levels/secretary_level.tscn")
		

func _ready() -> void:
	spin()
	#display_message.show()
	pass
