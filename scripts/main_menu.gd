extends Node2D


func check_click(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return 1

func _ready() -> void:

	tail_pos = $CanvasLayer/bat/sprite/tail.position.y
	
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
	label.text = "Start"
#
func _on_left_mouse_exited() -> void:
	$CanvasLayer/bat/sprite/wing2.modulate = Color(1,1,1,1.0)
	label.text = ""
	

func _on_right_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		$CanvasLayer/bat/sprite/wing1.modulate = Color(1.9,1.9,1.9,1.0)
		print('click')

func _on_right_mouse_entered() -> void:
	$CanvasLayer/bat/sprite/wing1.modulate = Color(1.4,1.4,1.4,1.0)
	label.text = "Settings"

func _on_right_mouse_exited() -> void:
	$CanvasLayer/bat/sprite/wing1.modulate = Color(1,1,1,1.0)
	label.text = ""
	

func _on_center_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		$CanvasLayer/bat/sprite/body.modulate = Color(1.9,1.9,1.9,1.0)
		print('click')

func _on_center_mouse_entered() -> void:
	$CanvasLayer/bat/sprite/body.modulate = Color(1.4,1.4,1.4,1.0)
	label.text = "Shop"

func _on_center_mouse_exited() -> void:
	$CanvasLayer/bat/sprite/body.modulate = Color(1,1,1,1.0)
	label.text = ""
	
