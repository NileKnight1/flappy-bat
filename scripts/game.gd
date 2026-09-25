extends Node2D


func _ready() -> void:
	start_game()
	


func start_game():
	game_running = 1
	spawn_obstacle()
	#spawn_obstacle()
	#spawn_obstacle()
	#spawn_obstacle()

var game_running = 0

var obstacles_count = 0


func _process(delta: float) -> void:
	if !game_running: return
	obstacles_count = $map/obstacles.get_child_count()
	$map/obstacles.position.x -= 5
	
	while obstacles_count < 20:
		obstacles_count = $map/obstacles.get_child_count()
		spawn_obstacle()
	


var cur_x = 0
var ref = preload("res://scenes/ref.tscn")
var y1 = -140.0
var y2 = 124

var gap = 150
var cur_x_diff = 700

# 200/200/198/ -100
# 150/150/148 -75

func spawn_obstacle():
	var temp_size = randi_range(100,460-gap)
	#var temp_size = 460-gap
	
	var temp = ref.instantiate()
	temp.game = self
	
	temp.position.x = cur_x
	temp.position.y = y1
	
	temp.get_node("col").shape = temp.get_node("col").shape.duplicate()
	temp.get_node("ref").get_node("col").shape = temp.get_node("ref").get_node("col").shape.duplicate()
	
	temp.position.y = y1-((200-temp_size)/2)
	temp.get_node("panel").position.y = -100 + (200-temp_size)/2
	temp.get_node("panel").size.y = temp_size
	temp.get_node("col").shape.size.y = temp_size
	temp.get_node("ref").get_node("col").shape.size.y = temp_size-2
	
	$map/obstacles.add_child(temp)
	
	temp = ref.instantiate()
	temp.position.x = cur_x
	temp.game = self
	
	temp.get_node("col").shape = temp.get_node("col").shape.duplicate()
	temp.get_node("ref").get_node("col").shape = temp.get_node("ref").get_node("col").shape.duplicate()
	
	temp_size = 464-gap-temp_size
	#print(temp_size)
	#print(y2+(200-temp_size)/2)
	temp.position.y = (y2+(200-temp_size)/2)
	temp.get_node("panel").size.y = temp_size
	temp.get_node("panel").position.y = -100 + (200-temp_size)/2 
	temp.get_node("col").shape.size.y = temp_size
	temp.get_node("ref").get_node("col").shape.size.y = temp_size-2
	
	$map/obstacles.add_child(temp)
	# 250/74
	# 200/124
	# 150/150
	
	cur_x += cur_x_diff

func _on_boundaries_body_entered(body: Node2D) -> void:
	#print(body)
	if body == $player:
		kill()

func kill():
	#game_running = 0
	print("dead")
	$player.get_node("col").set_deferred("disabled", 1)
	await get_tree().create_timer(0.01).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	


func _on_obstacles_area_body_entered(body: Node2D) -> void:
	print(body)
