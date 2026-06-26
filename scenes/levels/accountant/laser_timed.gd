extends Node2D
@onready var laser: TileMapLayer = $Laser
@export var delay : float = 0
var laser_on : bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	await get_tree().create_timer(delay).timeout
	if laser_on:
		laser.collision_enabled = false
		laser.modulate = Color(1, 1, 1, 0.2)
		laser_on = false
	else:
		laser.collision_enabled = true
		laser.modulate = Color(1, 1, 1, 1)
		laser_on = true
