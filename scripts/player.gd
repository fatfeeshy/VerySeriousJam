extends CharacterBody2D

var speed := 100
var jump := 80
var gravity := 5
var acceleration := 20

func _physics_process(_delta: float) -> void:
	Movement()
	Jumping()
	Gravity()
	move_and_slide()

func Movement():
	var direction = Input.get_axis("left", "right")
	var speed_formula = speed * direction
	velocity.x = move_toward(velocity.x, speed_formula, acceleration)

func Jumping():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump

func Gravity():
	if is_on_floor():
		return
	velocity.y += gravity
