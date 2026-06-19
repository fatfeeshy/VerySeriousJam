extends Node2D

@onready var wheel: Sprite2D = $Wheel
@onready var display_message: Label = $DisplayMessage

# TODO instaed of end states use and change the level
enum EndStates {
	L1,
	L2,
	L3,
	L4
}

const SECTION_ANGLES = {
	EndStates.L1: 45.0,
	EndStates.L2: 135.0,
	EndStates.L3: 225.0,
	EndStates.L4: 315.0
}

func spin():
	display_message.text = ""

	var result = EndStates.values().pick_random()

	var full_spins = randi_range(4, 8)

	var offset = randf_range(-20.0, 20.0)
	print(result)
	var target_rotation = rotation_degrees + full_spins * 360 + SECTION_ANGLES[result] + offset

	var tween = create_tween()
	# IDK about the diff transition types testing seems all similar 
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_IN)

	tween.tween_property(
		wheel,
		"rotation_degrees",
		target_rotation,
		randf_range(2.5, 4.0)
	)

	await tween.finished

	match result:
		EndStates.L1:
			display_message.text = "Level 1!"
		EndStates.L2:
			display_message.text = "Level 2!"
		EndStates.L3:
			display_message.text = "Level 3!"
		EndStates.L4:
			display_message.text = "Level 4!"
	
func _ready() -> void:
	#spin()
	#display_message.show()
	pass
