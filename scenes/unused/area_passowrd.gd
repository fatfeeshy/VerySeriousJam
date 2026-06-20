extends Area2D

@onready var label: Label = $Label

var number := 0

func _on_body_entered(_body: Node2D) -> void:
	number += 1
	label.text = "password: " + str(number % 10)
	print("stuff")
func _physics_process(_delta: float) -> void:
	pass
