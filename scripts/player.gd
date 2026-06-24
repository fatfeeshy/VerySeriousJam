extends CharacterBody2D
signal reset
@onready var quack: AudioStreamPlayer = $Quack

var speed := 90
var jump := -125
var gravity := 4
var acceleration := 19
var facing : int
var dead : bool

@onready var jump_buffer: Timer = $JumpBuffer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var camera: Camera2D = $Camera
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_path: PathFollow2D = $DeathPath/PathFollow
@onready var death_sprite: Sprite2D = $DeathPath/PathFollow/DeathSprite
@onready var death_animation: AnimationPlayer = $DeathPath/PathFollow/DeathSprite/AnimationPlayer

var propeller_hat_jump_is_on : bool
var propeller_hat_jump := -180
var propeller_hat_gravity := 3

var normal_jump := -125
var normal_gravity := 4

@export var wind_force := 0.0
var wind_acceleration := 3.0

var last_checkpoint : Vector2
enum Outfits {
	BUSINESS,
	BUSINESS_SILLY,
	SILLY
}
var curr_outfit = Outfits.BUSINESS_SILLY

func get_anim_name(state: String) -> String:
	match curr_outfit:
		Outfits.BUSINESS:
			return "business_" + state
		Outfits.BUSINESS_SILLY:
			return "business_silly_" + state
		Outfits.SILLY:
			return "silly_" + state

	return state
func _ready() -> void:
	# Sets camera limit for player or other necessary variables
	match get_tree().current_scene.name:
		"SecretaryLevel":
			camera.limit_bottom = 180
			camera.limit_right = 688
			camera.limit_left = 0
			camera.limit_top = -312
		"FriendLevel":
			camera.limit_bottom = 185
			camera.limit_right = 320
			camera.limit_left = 0
			camera.limit_top = -1540
	update_jump_settings()

func _physics_process(_delta: float) -> void:
	if dead:
		check_path_progress()
		return
	Movement()
	Jumping()
	Gravity()
	ApplyWind()
	Animations()
	if Input.is_action_just_pressed("quack"):
		quack.play()
	move_and_slide()

# --- RESPAWNING --- #

func set_checkpoint_at(checkpoint_pos: Vector2):
	last_checkpoint = checkpoint_pos

func die():
	dead = true
	sprite.visible = false
	death_sprite.visible = true
	death_animation.play("spin")
	emit_signal("reset") # For accountant level
	# begin death fade animation

func check_path_progress():
	print(death_path.progress_ratio)
	var path_progress_speed := 0.015
	if death_path.progress_ratio >= 0.97:
		respawn()
	else:
		death_path.progress_ratio += path_progress_speed

func respawn():
	dead = false
	sprite.visible = true
	death_sprite.visible = false
	position = last_checkpoint # Then set the player back to the checkpoint
	death_path.progress_ratio = 0.0
	death_animation.stop()

# --- HORIZONTAL AND VERTICAL MOVEMENT --- #
var wind_velocity := 0.0

func Movement():
	var direction := Input.get_axis("left", "right")
	var speed_formula = speed * direction
	
	velocity.x = move_toward(velocity.x, speed_formula + wind_velocity, acceleration)
	
	if Input.is_action_pressed("left"): facing = -1
	if Input.is_action_pressed("right"): facing = 1

var jumped : bool # supposed to be outside of Jumping()
func Jumping():
	var attempted_buffer : bool
	
	# Mini State Machine
	if is_on_floor():
		attempted_buffer = false
		jumped = false
	
	# Regular Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Jump()
	
	# Jump Buffer Logic
	if Input.is_action_just_pressed("jump") and not is_on_floor()\
											and not attempted_buffer:
		jump_buffer.start()
		attempted_buffer = true
	if jump_buffer.is_stopped():
		return
	if is_on_floor():
		Jump()
	
	# Coyote Time Logic
	if not is_on_floor() and not jumped:
		coyote_timer.start()
	if coyote_timer.is_stopped():
		return
	if Input.is_action_just_pressed("jump"):
		Jump()

func Jump():
	velocity.y = jump
	jumped = true

func Gravity():
	if is_on_floor():
		return
	velocity.y += gravity

func ApplyWind():
	wind_velocity = move_toward(
		wind_velocity,
		wind_force,
		wind_acceleration
		)

func _on_hurtbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		die()
		print("dead")

func Animations():
	# flip
	sprite.flip_h = facing == -1

	var state := ""

	if is_on_floor():
		if abs(velocity.x) > 0.0:
			state = "run"
		else:
			state = "idle"
	elif velocity.y < 0.0:
		state = "jump"
	else:
		state = "fall"

	var anim_name = get_anim_name(state)

	if sprite.animation != anim_name:
		sprite.play(anim_name)

func update_jump_settings():
	if propeller_hat_jump_is_on:
		jump = propeller_hat_jump
		gravity = propeller_hat_gravity
	else:
		jump = normal_jump
		gravity = normal_gravity
