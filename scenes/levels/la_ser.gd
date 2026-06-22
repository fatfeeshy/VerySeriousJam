extends Node2D
#
#@onready var line_2d: Line2D = $Line2D
#@onready var ray_cast_2d: RayCast2D = $RayCast2D
#
#func _process(delta):
	#ray_cast_2d.force_raycast_update()
#
	#var end_point = ray_cast_2d.target_position
#
	#if ray_cast_2d.is_colliding():
		#end_point = to_local(ray_cast_2d.get_collision_point())
#
	#line_2d.points = [Vector2.ZERO, end_point]
