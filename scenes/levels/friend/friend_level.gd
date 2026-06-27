extends Node2D

@onready var wind_timer: Timer = $WindTimer
@onready var off_timer: Timer = $OffTimer
@onready var friend: Area2D = $Friend

#var wind_on := false

func _ready():
	start_wind()
	friend.set_text("Lets be silly together!")
	
func start_wind():
	#wind_on = true
	wind_timer.start()      

func stop_wind():
	#wind_on = false
	off_timer.start()   
	
func _on_wind_timer_timeout():
	stop_wind()

func _on_off_timer_timeout():
	start_wind()
