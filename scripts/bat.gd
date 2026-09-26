extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
var game_running = 0

func _ready() -> void:
	#var tween = create_tween()
	#tween.set_loops()
	#tween.tween_property($sprite/wing1, "rotation", deg_to_rad(7), 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property($sprite/wing1, "rotation", deg_to_rad(-7), 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#
	#var tween2 = create_tween()
	#tween2.set_loops()
	#tween2.tween_property($sprite/wing2, "rotation", deg_to_rad(-7), 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween2.tween_property($sprite/wing2, "rotation", deg_to_rad(7), 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	
	tail_pos = $sprite/tail.position.y
	
	tween_rotation($sprite/wing1, 7, 0.2)
	tween_rotation($sprite/wing2, 7, 0.2, -1)
	
	
	tween_rotation($sprite/ear1, 1.5, 0.5)
	tween_rotation($sprite/ear2, 1.5, 0.5, -1)
	

func tween_rotation(node, rot, time, rev = 1):
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(node, "rotation", deg_to_rad(rot*rev), time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "rotation", deg_to_rad(-rot*rev), time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
var tail_pos

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !game_running: return
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		var tween = create_tween()
		#var tween2 = create_tween()
		
		#tween.tween_property($sprite/tail, "position:y", tail_pos+1, 0.2)
		#tween.tween_property($sprite/tail, "position:y", tail_pos-1, 0.2)
		
		#tween.tween_property($sprite/wing1, "scale", Vector2(1.05,1.05), 0.2)
		#tween2.tween_property($sprite/wing2, "scale", Vector2(1.05,1.05), 0.2)
		
		#tween.tween_property($sprite/wing1, "scale", Vector2(1,1), 0.2)
		#tween2.tween_property($sprite/wing2, "scale", Vector2(1,1), 0.2)
		
		tween.tween_property($sprite, "scale", Vector2(1.05,1.05), 0.2)
		tween.tween_property($sprite, "scale", Vector2(1,1), 0.2)
		
		
		
		
		#
	move_and_slide()

func _on_eyes_timeout() -> void:
	$sprite/eyes.visible = 1
	await get_tree().create_timer(0.15).timeout
	$sprite/eyes.visible = 0
