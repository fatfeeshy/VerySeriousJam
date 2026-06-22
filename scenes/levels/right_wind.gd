extends Area2D

@export var wind_force := 30.0

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.wind_force += wind_force

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.wind_force -= wind_force
