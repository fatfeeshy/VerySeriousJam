extends CharacterBody2D

var speed := 100
var jump := 80
var gravity := 5
var acceleration := 20

@onready var jump_buffer: Timer = $JumpBuffer
@onready var coyote_timer: Timer = $CoyoteTimer

func _physics_process(_delta: float) -> void:
	Movement()
	Jumping()
	Gravity()
	move_and_slide()

func Movement():
	var direction := Input.get_axis("left", "right")
	var speed_formula = speed * direction
	velocity.x = move_toward(velocity.x, speed_formula, acceleration)

var jumped : bool # supposed to be outside of Jumping()
func Jumping():
	#var jump_key_is_held := Input.is_action_pressed("jump")
	var attempted_buffer : bool
	
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
	velocity.y -= jump
	jumped = true

func Gravity():
	if is_on_floor():
		return
	velocity.y += gravity
