extends Node2D

@onready var animation_player: AnimationPlayer = $Intro/AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var boss: Area2D = $Boss
@onready var propeller_drop_timer: Timer = $PropellerDropTimer
@onready var propeller_path: PathFollow2D = $ItemDropPath/PathFollow2D
@onready var item_get: AudioStreamPlayer = $ItemGet
@onready var beam_fire: AudioStreamPlayer = $BeamFire

func _ready() -> void:
	player.visible = true
	player.scale = Vector2.ONE
	friend.visible = false
	secretary.visible = false
	accountant.visible = false
	player.last_checkpoint = Vector2(40, 126)
	player.position = player.last_checkpoint
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
		if boss.died:
			current_propeller.queue_free()
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

# --- DEATH SEQUENCE --- #

@onready var friend: Sprite2D = $DeathSequence/Node2D/Friend
@onready var accountant: Sprite2D = $DeathSequence/Node2D/Accountant
@onready var secretary: Sprite2D = $DeathSequence/Node2D/Secretary

@onready var player_checker: Area2D = $DeathSequence/PlayerChecker
@onready var spacebar_prompt: AnimatedSprite2D = $DeathSequence/SpacebarPrompt
@onready var spin_to_win: Label = $DeathSequence/SpinToWin
@onready var npc_spin: AnimationPlayer = $DeathSequence/NPCSpin

func npc_spin_player_play_idle():
	player.play_idle()

func npc_spin_stop_boss_attack():
	boss.stop_attack()

func spacebar_pressed():
	await get_tree().process_frame
	while not Input.is_action_just_pressed("jump"):
		await get_tree().process_frame

func show_prompt(hide: bool) -> void:
	if hide == false:
		spacebar_prompt.visible = false
		spin_to_win.visible = false
	else:
		spacebar_prompt.visible = true
		spin_to_win.visible = true

func player_is_under_boss():
	if player_checker.has_overlapping_bodies():
		return
	await player_checker.body_entered

func _on_boss_death_sequence() -> void:
	# Boss moves to center
	var tween := get_tree().create_tween()
	tween.tween_property(boss, "global_position", Vector2(160, 68), 0.3)
	await tween.finished
	
	await player_is_under_boss()
	beam_fire.play()
	player.visible = false
	player.boss_dead = true
	
	boss.constant_attack()
	
	await get_tree().create_timer(3).timeout
	show_prompt(true)
	
	await get_tree().create_timer(0.2).timeout
	await spacebar_pressed()
	npc_spin.play("npc_spin")
	await npc_spin.animation_finished

	show_prompt(false)
	get_tree().change_scene_to_file("res://scenes/game/outro.tscn")
