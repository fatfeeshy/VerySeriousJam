extends Node2D
@onready var subtitles: Label = $Subtitles
@onready var audio: AudioStreamPlayer2D = $Audio
@onready var image: TextureRect = $Image
signal cutscene_finished
var slides = [
	{
		"time": 0.0,
		"texture": preload("uid://cnigun58xf13s"),
		"text": "Pick up a duck"
	},
	{
		"time": 2,
		"texture": preload("uid://esiacrsuhh51"),
		"text": "Step 1: Find a Duck"
	},
	{
		"time": 4,
		"texture": preload("uid://dhdye2k0vwqw8"),
		"text": "Have you found your duck?"
	},
	{
		"time": 6.9,
		"texture": preload("uid://flbuelk2x745"),
		"text": "Step 2:"
	},
	{
		"time": 8.1,
		"texture": preload("uid://dbex61ws7wic7"),
		"text": "Plcae your hand underneath the duck"
	},
	{
		"time": 13,
		"texture": preload("uid://dqsttlemof1vl"),
		"text": "congraduation!"
	},
	{
		"time": 14.0,
		"texture": preload("uid://0fl3wfw5gv4h"),
		"text": "YOu have now picked up a duck!"
	}
]

var current_slide = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio.stream = preload("res://assets/cutscene/test/how-to-pick-up-a-duck.mp3")
	image.texture = slides[0].texture
	subtitles.text = slides[0].text
	audio.play()
	image.size = Vector2(320,180)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_slide >= slides.size() - 1:
		return

	var current_time = audio.get_playback_position()

	if current_time >= slides[current_slide + 1].time:
		current_slide += 1
		image.texture = slides[current_slide].texture
		subtitles.text = slides[current_slide].text


func _on_audio_finished() -> void:
	emit_signal("cutscene_finished")
