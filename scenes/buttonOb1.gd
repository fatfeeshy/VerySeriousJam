extends Area2D
@onready var laser_ob_1: TileMapLayer = $"../LaserOb1"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	laser_ob_1.collision_enabled = false
	laser_ob_1.modulate = Color(1, 1, 1, 0.3)
