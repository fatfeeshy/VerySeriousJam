extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_p_1_on_pressed() -> void:
	var value = (int(self.text) + 1) % 10
	self.text = str(value)
