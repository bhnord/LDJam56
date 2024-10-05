extends Area2D
class_name Hook

var TYPE = randi() % 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(TYPE)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact():
	SceneManager.switch_to_scene(SceneManager.Scene.PULLING_ROD)
