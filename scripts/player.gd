extends CharacterBody2D

var speed := 90
var jump := -125
var gravity := 4
var acceleration := 19

@onready var jump_buffer: Timer = $JumpBuffer
@onready var coyote_timer: Timer = $CoyoteTimer

var propeller_hat_jump_is_on : bool
var propeller_hat_jump := -180
var propeller_hat_gravity := 3

func _ready() -> void:
	# Activates propeller hat controls
	if propeller_hat_jump_is_on:
		jump = propeller_hat_jump
		gravity = propeller_hat_gravity
	else:
		jump = jump
		gravity = gravity

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
