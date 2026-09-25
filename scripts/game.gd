extends Node2D


func _ready() -> void:
	start_game()
	


func start_game():
	game_running = 1
	spawn_obstacle()
	spawn_obstacle()
	spawn_obstacle()
	spawn_obstacle()

var game_running = 0

var obstacles_count = 0


func _process(delta: float) -> void:
	if !game_running: return
	obstacles_count = $map/obstacles.get_child_count()
	$map/obstacles.position.x -= 5
	
	while obstacles_count < 10:
		obstacles_count = $map/obstacles.get_child_count()
		spawn_obstacle()
	


var cur_x = 0
var ref = preload("res://scenes/ref.tscn")
var y1 = -111.0
var y2 = 210.0

var gap = 80

# 200/200/198/ -100
# 150/150/148 -75

func spawn_obstacle():
	var temp = ref.instantiate()
	temp.position.x = cur_x
	temp.position.y = y1
	#print(temp.game)
	temp.game = self
	#print(temp.game)
	var temp_size = 150
	#print(-100 + (200-150)/2 )
	
	temp.get_node("panel").size.y = temp_size
	temp.get_node("panel").position.y = -100 + (200-150)/2 
	temp.get_node("col").shape.size.y = temp_size
	temp.get_node("ref").get_node("col").shape.size.y = temp_size-2
	
	
	$map/obstacles.add_child(temp)
	#
	#temp = ref.instantiate()
	#temp.position.x = cur_x
	#temp.position.y = y2
	#temp.game = self
	#$map/obstacles.add_child(temp)
	
	cur_x += 300

func _on_boundaries_body_entered(body: Node2D) -> void:
	#print(body)
	if body == $player:
		kill()

func kill():
	#game_running = 0
	print("dead")
	
	pass


func _on_obstacles_area_body_entered(body: Node2D) -> void:
	print(body)
