extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var checkpoint: Area2D = $Checkpoints/Checkpoint

@onready var green_timer: Timer = $GreenTimer
@onready var red_timer: Timer = $RedTimer
@onready var transition_timer: Timer = $TransitionTimer

var red : bool
var player_at_risk : bool
var won : bool

func _ready():
	won = false
	player.last_checkpoint = checkpoint.global_position
	player.secretary_panel.visible = true
	green_light()

func _process(_delta: float) -> void:
	if not red:
		return
	red_light()

# --- RED LIGHT, GREEN LIGHT LOGIC --- #

func green_light():
	randomize()
	player.update_border_color("green")
	var more_green_time = randf_range(0.0, 2.0)
	green_timer.wait_time = 3.0 + more_green_time
	green_timer.start()

func _on_green_timer_timeout() -> void:
	if won == true:
		return
	transition_light()

func transition_light():
	player.update_border_color("red")
	transition_timer.start()

func _on_transition_timer_timeout() -> void:
	red_light()
	red_timer.start()

func red_light():
	red = true
	if player.velocity != Vector2.ZERO or player_at_risk:
		red_timer.stop()
		red_timer.timeout.emit()
		player.die()

func _on_red_timer_timeout() -> void:
	red = false
	green_light()

func _on_winzone_body_entered(body: CharacterBody2D) -> void:
	if not body is CharacterBody2D:
		return
	transition_timer.stop()
	red_timer.stop()
	green_light()
	won = true

# --- REDZONES --- #

func _on_redzone_entered(body: CharacterBody2D) -> void:
	player_at_risk = true

func _on_redzone_exited(body: CharacterBody2D) -> void:
	player_at_risk = false
