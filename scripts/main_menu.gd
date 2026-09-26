extends Node2D

var stop_clicks = 1
func check_click(event):
	if stop_clicks: return 0
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return 1



func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#
	#var tween = create_tween().set_parallel()
	#tween.tween_property($CanvasLayer/bat/sprite/wing2, "modulate", Color(1.6, 1.6, 1.6, 1.0), 0.5)
	#label.text = "Settings"
	#tween.tween_property(label, "modulate", Color(1.6, 1.6, 1.6, 1.0), 0.5)
	#await get_tree().create_timer(2).timeout
	#var tween2 = create_tween().set_parallel()
	#tween2.tween_property($CanvasLayer/bat/sprite/wing2, "modulate", Color(1, 1, 1, 1.0), 0.5)
	#label.text = "Play"
	#tween2.tween_property(label, "modulate", Color(1.6, 1.6, 1.6, 1.0), 0.5)
	#tween2.tween_property($CanvasLayer/bat/sprite/body, "modulate", Color(1.6, 1.6, 1.6, 1.0), 0.5)
	#await get_tree().create_timer(2).timeout
	#var tween4 = create_tween().set_parallel()
	#tween4.tween_property($CanvasLayer/bat/sprite/body, "modulate", Color(1, 1, 1, 1.0), 0.5)
	#label.text = "Shop"
	#tween4.tween_property(label, "modulate", Color(1.6, 1.6, 1.6, 1.0), 0.5)
	#tween4.tween_property($CanvasLayer/bat/sprite/wing1, "modulate", Color(1.6, 1.6, 1.6, 1.0), 0.5)
	#await get_tree().create_timer(2).timeout
	#var tween5 = create_tween().set_parallel()
	#tween5.tween_property($CanvasLayer/bat/sprite/wing1, "modulate", Color(1, 1, 1, 1.0), 0.5)
	#tween5.tween_property(label, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)
	#
	#await get_tree().create_timer(1).timeout
	stop_clicks = 0
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	bat_def =  $CanvasLayer/bat.position.x
	
	tween_rotation($CanvasLayer/bat/sprite/wing1, 7, 0.2)
	tween_rotation($CanvasLayer/bat/sprite/wing2, 7, 0.2, -1)
	
	tween_rotation($CanvasLayer/bat/sprite/ear1, 1.5, 0.5)
	tween_rotation($CanvasLayer/bat/sprite/ear2, 1.5, 0.5, -1)
	

func tween_rotation(node, rot, time, rev = 1):
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(node, "rotation", deg_to_rad(rot*rev), time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "rotation", deg_to_rad(-rot*rev), time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
var tail_pos


func _on_eyes_timeout() -> void:
	$CanvasLayer/bat/sprite/eyes.visible = 1
	await get_tree().create_timer(0.15).timeout
	$CanvasLayer/bat/sprite/eyes.visible = 0

@onready var label: Label = $CanvasLayer/CenterContainer/Label

func _on_left_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		$CanvasLayer/bat/sprite/wing2.modulate = Color(1.9,1.9,1.9,1.0)
		print('click')

func _on_left_mouse_entered() -> void:
	$CanvasLayer/bat/sprite/wing2.modulate = Color(1.4,1.4,1.4,1.0)
	#label.text = "Start"
	label_show("Settings")
	
#
func _on_left_mouse_exited() -> void:
	$CanvasLayer/bat/sprite/wing2.modulate = Color(1,1,1,1.0)
	label_hide()
	

var  bat_def

var shop_open = 0

func _on_right_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		$CanvasLayer/bat/sprite/wing1.modulate = Color(1.9,1.9,1.9,1.0)
		print('click')
		
		if !shop_open:
			shop_open = 1
			var tween = create_tween()
			tween.tween_property($CanvasLayer/bat, "position:x", bat_def-750, 0.4)
		else:
			shop_open = 0
			var tween = create_tween()
			tween.tween_property($CanvasLayer/bat, "position:x", bat_def, 0.4)

func _on_right_mouse_entered() -> void:
	$CanvasLayer/bat/sprite/wing1.modulate = Color(1.4,1.4,1.4,1.0)
	#label.text = "Settings"
	if !shop_open:
		label_show("Shop")
	else:
		label_show("Back")
		
	

func _on_right_mouse_exited() -> void:
	$CanvasLayer/bat/sprite/wing1.modulate = Color(1,1,1,1.0)
	label_hide()
	

func _on_center_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		$CanvasLayer/bat/sprite/body.modulate = Color(1.9,1.9,1.9,1.0)
		print('click')
		var tween = create_tween().set_parallel()
		tween.tween_property($CanvasLayer/bat, "scale", Vector2(32,32), 0.5)
		tween.tween_property($CanvasLayer/fade, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.5)
		

func _on_center_mouse_entered() -> void:
	$CanvasLayer/bat/sprite/body.modulate = Color(1.4,1.4,1.4,1.0)
	#label.text = "Shop"
	label_show("Play")
	

func _on_center_mouse_exited() -> void:
	$CanvasLayer/bat/sprite/body.modulate = Color(1,1,1,1.0)
	label_hide()

func label_show(msg):
	label.text = msg
	var tween = create_tween()
	tween.tween_property(label, "modulate", Color(1,1,1,1), 0.3)


func label_hide():
	var tween = create_tween()
	tween.tween_property(label, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.1)
