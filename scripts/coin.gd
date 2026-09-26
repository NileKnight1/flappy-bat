extends Area2D

@onready var game = $"../../.."

func _on_body_entered(body: Node2D) -> void:
	if body.name == "free":
		queue_free()
	if body.name == "player":
		game.add_coin()
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(0,0), 0.3)
		await get_tree().create_timer(0.1).timeout
		queue_free()
		
