extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0

func _ready() -> void:
	var tween = create_tween()
	var tween2 = create_tween()
	tween.set_loops(true)
	tween2.set_loops(true)
	
	tween.tween_property($sprite/wing1, "rotation", deg_to_rad(7), 0.5)
	tween.tween_property($sprite/wing1, "rotation", deg_to_rad(-7), 0.5)
	
	tween2.tween_property($sprite/wing2, "rotation", deg_to_rad(7), 0.5)
	tween2.tween_property($sprite/wing2, "rotation", deg_to_rad(-7), 0.5)
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
	
	
	move_and_slide()
