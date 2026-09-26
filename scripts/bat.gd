extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
var game_running = 0


var colours = [
	["541880"],
	["dcbe95"],
	["c4c4c0"],
	["d97a4a"],
	["b8d4dc"],
	
]

@export var style_num = global.bat_colour

func set_style(num):
	style_num = num
	for i in $sprite.get_children():
		if i.get_children():
			if i.name == "eyes": continue
			for j in i.get_children():
				if j is Panel:
					var style = j.get_theme_stylebox("panel").duplicate()
					style.bg_color = Color(colours[style_num][0])
					j.add_theme_stylebox_override("panel", style)
				elif j.name == "color":
					j.color = colours[style_num][0]
					
		#else:
			#if i is Panel:
				#var style = i.get_theme_stylebox("panel").duplicate()
				#style.bg_color = Color(colours[style_num][0])
				#i.add_theme_stylebox_override("panel", style)
			#elif i.name == "color":
				#i.color = colours[style_num][0]


func _ready() -> void:
	set_style(style_num)
	
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
