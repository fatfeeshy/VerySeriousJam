extends Node

@onready var text_box_scene = preload("res://text box/text_box.tscn")
@onready var sfx_1: AudioStreamPlayer2D = $SFX1

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box: TextBox
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

signal dialog_finished()

func start_dialog(position: Vector2, lines: Array[String]):
	if is_dialog_active:
		return 
	
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index])
	sfx_1.play()
	can_advance_line = false
	
func _on_text_box_finished_displaying():
	can_advance_line = true
	
#func _unhandled_input(event: InputEvent) -> void:
	#if (
		#(event.is_action_pressed("advance_dialog") || event.is_action_pressed("interact")) &&
		#is_dialog_active &&
		#can_advance_line
	#):
		#text_box.queue_free()
		#
		#current_line_index += 1
		#if current_line_index >= dialog_lines.size():
			#is_dialog_active = false
			#current_line_index = 0
			#dialog_finished.emit()
			#return
		#
		#_show_text_box()
	#
func _process(delta):
	if not is_dialog_active:
		return

	if Input.is_action_just_pressed("advance_dialog"):
		_advance_dialog()

func _advance_dialog():
	if not can_advance_line:
		return

	text_box.queue_free()

	current_line_index += 1

	if current_line_index >= dialog_lines.size():
		is_dialog_active = false
		current_line_index = 0
		dialog_finished.emit()
		return

	_show_text_box()
