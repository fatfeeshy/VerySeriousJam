extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite


var lines: Array[String] = [
	"What happens when you tell an egg a joke",
	"It cracks up!"
	
]
func _physics_process(delta): 
##	var direction = (main.position - position).normalized()
	#var move_vector = direction * speed
	##linear_velocity = move_vector
	
	pass

	"HI EXAMPLEING"
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	sprite.play("new_animation")
	#sprite.play("idle")
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
