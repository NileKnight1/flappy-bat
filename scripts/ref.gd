extends Area2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


var game
func _on_ref_body_entered(body: Node2D) -> void:
	#print(body)
	if body.name == "player":
		game.kill()
	if body.name == "free":
		self.queue_free()
