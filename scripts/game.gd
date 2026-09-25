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
	
	while obstacles_count < 20:
		spawn_obstacle()
	


var cur_x = 0
var ref = preload("res://scenes/ref.tscn")
var y1 = -111.0
var y2 = 210.0


func spawn_obstacle():
	var temp = ref.instantiate()
	temp.position.x = cur_x
	temp.position.y = y1
	print(temp.game)
	temp.game = self
	print(temp.game)
	
	$map/obstacles.add_child(temp)
	
	temp = ref.instantiate()
	temp.position.x = cur_x
	temp.position.y = y2
	temp.game = self
	$map/obstacles.add_child(temp)
	
	cur_x += 300

func _on_boundaries_body_entered(body: Node2D) -> void:
	#print(body)
	if body == $player:
		kill()

func kill():
	#game_running = 0
	print("dead")


func _on_obstacles_area_body_entered(body: Node2D) -> void:
	if body.name == "ref":
		print(body)
