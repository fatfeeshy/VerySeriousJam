extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_player_reset():
	self.modulate = Color(1, 1, 1, 1)
	self.collision_enabled = true
