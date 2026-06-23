extends MarginContainer
class_name TextBox

@onready var timer: Timer = $LetterDisplayTimer
@onready var label: Label = $MarginContainer/Label

const MAX_WIDTH := 200

var text := ""
var letter_index := 0

var letter_time := 0.03
var space_time := 0.06
var punctuation_time := 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	# Reset state for a new line of dialogue
	text = text_to_display
	letter_index = 0

	# Reset sizing/wrapping from previous dialogue
	custom_minimum_size = Vector2.ZERO
	label.autowrap_mode = TextServer.AUTOWRAP_OFF

	# Measure text
	label.text = text
	await resized

	custom_minimum_size.x = min(size.x, MAX_WIDTH)

	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		custom_minimum_size.y = size.y

	# Position above the NPC
	global_position.x -= size.x / 3.0
	global_position.y -= (size.y + 24) * scale.y

	# Clear and start typewriter effect
	label.text = ""

	if text.length() > 0:
		_display_letter()
	else:
		finished_displaying.emit()

func _display_letter():
	label.text += text[letter_index]
	letter_index += 1

	if letter_index >= text.length():
		finished_displaying.emit()
		return

	match text[letter_index]:
		".", ",", "!", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

func _on_letter_display_timer_timeout() -> void:
	_display_letter()
