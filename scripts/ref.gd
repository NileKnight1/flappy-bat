extends Area2D


var game
func _on_ref_body_entered(body: Node2D) -> void:
	#print(body)
	if body.name == "player":
		if game.game_running:
			game.kill()
	if body.name == "free":
		print('freed')
		#game.spawn_obstacle()
		#await get_tree().create_timer(0.01).timeout
		self.queue_free()

func _on_pnt_body_entered(body: Node2D) -> void:
	if body.name == "player":
		game.add_point()
