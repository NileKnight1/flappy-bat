extends Node2D


func _ready() -> void:
	#$CanvasLayer/restart.position.x += 230
	$CanvasLayer/restart.scale = Vector2(0.1,0.1)
	
	$CanvasLayer/red.modulate = Color(0.0, 0.0, 0.0, 1.0)
	$CanvasLayer/coins.text = "Coins: " + str(global.coins)
	start_game()

func start_game():
	$CanvasLayer/red.modulate = Color(0.0, 0.0, 0.0, 1.0)
	
	game_running = 1
	$player.game_running =1
	$difficulty.start()
	spawn_obstacle()
	spawn_obstacle()
	spawn_obstacle()
	spawn_obstacle()

var game_running = 0

var obstacles_count = 0
var coins_count = 0


func _process(delta: float) -> void:
	if !game_running: return
	obstacles_count = $map/obstacles.get_child_count()
	coins_count = $map/coins.get_child_count()
	
	$map/obstacles.position.x -= game_speed
	$map/coins.position.x -= game_speed
	#$player.get_node("p").position.x -= game_speed
	
	
	
	while obstacles_count < 20:
		obstacles_count = $map/obstacles.get_child_count()
		spawn_obstacle()
	
	#while coins_count < 20:
		#coins_count = $map/coins.get_child_count()
		#spawn_coins()


var cur_x = 0
var ref = preload("res://scenes/ref.tscn")
var y1 = -140.0
var y2 = 124

# 200/200/198/ -100
# 150/150/148 -75

func spawn_obstacle():
	print("spawned")
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
	
	spawn_coins()
	spawn_coins()
	spawn_coins()
	
	$map/obstacles.add_child(temp)
	# 250/74
	# 200/124
	# 150/150
	
	cur_x += cur_x_diff

func spawn_coins():
	var temp = $map/coin.duplicate()
	temp.position.y = randi_range(-215, 211)
	temp.position.x = randi_range(cur_x+250,cur_x-250)
	
	
	$map/coins.add_child(temp)
	

func _on_boundaries_body_entered(body: Node2D) -> void:
	#print(body)
	if body == $player:
		kill()

func kill():
	game_running = 0
	$player.game_running =0

	print("dead")
	var tween = create_tween()
	tween.tween_property($CanvasLayer/red, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.3)
	#tween.tween_property($CanvasLayer/restart, "position:x", $CanvasLayer/restart.position.x - 250, 0.2)
	tween.tween_property($CanvasLayer/restart, "scale", Vector2(1,1), 0.2)
	
	
	$player.get_node("col").set_deferred("disabled", 1)
	await get_tree().create_timer(0.01).timeout
	#get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_obstacles_area_body_entered(body: Node2D) -> void:
	print(body)


var gap = 200
var cur_x_diff = 700
var game_speed = 5

func _on_difficulty_timeout() -> void:
	#return
	if game_speed < 10:
		game_speed += 0.5
	if gap > 100:
		gap -= 10
	if cur_x_diff > 450:
		cur_x_diff -= 25

var points = 0
var coins = 0

func add_point():
	global.highest_score = max(global.highest_score, points/2)
	points += 1
	$CanvasLayer/points.text = "Distance: " + str(points/2) + "m"
	print(points)
	#print("points")
func add_coin():
	coins += 1
	global.coins += 1
	$CanvasLayer/coins.text = "Coins: " + str(global.coins)
	print(points)


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
