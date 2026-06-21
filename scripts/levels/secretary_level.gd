extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var checkpoint: Area2D = $Checkpoints/Checkpoint

@onready var green_timer: Timer = $GreenTimer
@onready var red_timer: Timer = $RedTimer
@onready var transition_timer: Timer = $TransitionTimer

#var green : bool
var red : bool
var player_at_risk : bool

func _ready():
	player.last_checkpoint = checkpoint.global_position
	green_light()

func _process(_delta: float) -> void:
	if not red:
		return
	red_light()

# --- RED LIGHT, GREEN LIGHT LOGIC --- #

func green_light():
	randomize()
	var more_green_time = randf_range(0.5, 2.5)
	green_timer.wait_time = 3.0 + more_green_time
	print("Green time:", green_timer.wait_time)
	green_timer.start()
	print("GREEN LIGHT START")

func _on_green_timer_timeout() -> void:
	transition_light()
	transition_timer.start()

func transition_light():
	# Cool effect thing that is red
	print("STOP!!!")
	pass

func _on_transition_timer_timeout() -> void:
	red_light()
	red_timer.start()

func red_light():
	print("RED LIGHT")
	red = true
	if player.velocity != Vector2.ZERO:
		player.respawn()
		red = false
		green_timer.start()
		green_light()

func _on_red_timer_timeout() -> void:
	red = false
	green_timer.start()
	green_light()

# --- REDZONES --- #

func _on_redzone_entered(body: CharacterBody2D) -> void:
	player_at_risk = true

func _on_redzone_exited(body: CharacterBody2D) -> void:
	player_at_risk = false
