extends Area2D
class_name Hook

var TYPE = randi() % 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact():
	print("interacted")
	SceneManager.switch_to_scene(SceneManager.Scene.PULLING_ROD)


func _on_body_entered(body: Node2D) -> void:
	if body is Fish:
		body.add_hook(self)

func _on_body_exited(body: Node2D) -> void:
	if body is Fish:
		body.remove_hook(self)
