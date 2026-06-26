extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_player_reset():
	self.modulate = Color(1, 1, 1, 1)
	self.collision_enabled = true


func _on_button_on_pressed() -> void:
	self.collision_enabled = false
	self.modulate = Color(1, 1, 1, 0.2)
