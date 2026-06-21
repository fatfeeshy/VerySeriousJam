extends Area2D
@onready var laser_ob_2: TileMapLayer = $"../Tiles/LaserOb2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	laser_ob_2.collision_enabled = false
	laser_ob_2.modulate = Color(1, 1, 1, 0.2)
