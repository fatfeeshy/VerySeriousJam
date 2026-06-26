extends Node2D

@onready var animation_player: AnimationPlayer = $Intro/AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var boss: Area2D = $Boss
@onready var propeller_drop_timer: Timer = $PropellerDropTimer
@onready var propeller_path: PathFollow2D = $ItemDropPath/PathFollow2D
@onready var item_get: AudioStreamPlayer = $ItemGet

func _ready() -> void:
	player.last_checkpoint = Vector2(40, 126)
	player.dead = true

func _process(_delta: float) -> void:
	pass

func enable_player():
	player.dead = false
	propeller_drop_timer.start()
	boss.initialize()

# --- PROPELLER DROPS --- #

var current_propeller: Node = null
const propeller_pickup := preload("res://scenes/levels/propeller_hat_drop.tscn")

func spawn_propeller_drop():
	if current_propeller != null:
		return
	randomize()
	propeller_path.progress_ratio = randf()
	current_propeller = propeller_pickup.instantiate()
	current_propeller.global_position = propeller_path.global_position
	add_child(current_propeller)
	current_propeller.picked_up.connect(_on_propeller_drop_picked_up)

func _on_propeller_drop_picked_up() -> void:
	player.propeller_hat_jump_is_on = true
	current_propeller = null
	item_get.play()

func _on_propeller_drop_timer_timeout() -> void:
	spawn_propeller_drop()

func _on_player_died() -> void:
	player.propeller_hat_jump_is_on = false
	if current_propeller != null:
		current_propeller.queue_free()
