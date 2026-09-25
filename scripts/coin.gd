extends Area2D

@onready var game = $"../../.."

func _on_body_entered(body: Node2D) -> void:
	if body.name == "free":
		queue_free()
	if body.name == "player":
		game.add_coin()
		queue_free()
		
