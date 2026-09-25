extends Area2D


var game
func _on_ref_body_entered(body: Node2D) -> void:
	#print(body)
	if body.name == "player":
		game.kill()
	if body.name == "free":
		self.queue_free()

func _on_pnt_body_entered(body: Node2D) -> void:
	if body.name == "player":
		game.add_point()
