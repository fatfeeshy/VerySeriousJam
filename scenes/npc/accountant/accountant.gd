extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite


var lines: Array[String] = [
	"Hey?",
	"Oh you will tell me my fortnite password!"
	
]


func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	#sprite.play("new_animation")
	#sprite.play("idle")
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
