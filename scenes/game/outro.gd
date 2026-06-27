extends Node2D
@onready var subtitles: Label = $Subtitles
@onready var audio: AudioStreamPlayer2D = $Audio
@onready var image: TextureRect = $Image
@onready var outro_music: AudioStreamPlayer = $OutroMusic

var slides = [
	{
		"time": 0.0,
		"texture": preload("res://assets/cutscene/intro_outro/outro1.png"),
		"text": "It's a start"
	}
]

var current_slide = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#audio.stream = preload("res://assets/cutscene/intro_outro/OutroVerySerious.wav")
	image.texture = slides[0].texture
	subtitles.text = slides[0].text
	audio.play()
	image.size = Vector2(320,180)
	outro_music.play()

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
	await get_tree().create_timer(1).timeout
	#outro_music.stop()
