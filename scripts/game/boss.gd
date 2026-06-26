extends Area2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $"../Player"
@onready var attack_timer: Timer = $AttackTimer
@onready var attack_delay: Timer = $AttackDelay
@onready var hit_flash: AnimationPlayer = $HitFlash

var default_pos := Vector2(160, 68)
var health := 3

func _ready() -> void:
	animation.play("idle")
	hit_flash.play("init")
	position = default_pos

func initialize():
	animation.play("idle")
	hit_flash.play("init")
	attack_timer.start()
	position = default_pos
	health = 3

func _on_attack_timer_timeout() -> void:
	attack_player()

func attack_player():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "global_position:x", player.global_position.x, 0.3)
	await tween.finished
	animation.play("laser")
	await animation.animation_finished
	animation.play("idle")

func _on_laser_body_entered(body: CharacterBody2D) -> void:
	player.die()
	if player.dead == true:
		await get_tree().create_timer(1.0).timeout
		initialize()

func _on_boss_body_entered(body: CharacterBody2D) -> void:
	if not attack_delay.is_stopped():
		return
	take_damage()

func take_damage():
	# idk if having 2 identical if statements is bad in this case but uhhhh
	if health == 0:
		return
	hit_flash.play("hit_flash")
	player.propeller_hat_jump_is_on = false
	attack_delay.start()
	health -= 1
	if health == 0:
		die_sequence()

func die_sequence():
	attack_timer.stop()
