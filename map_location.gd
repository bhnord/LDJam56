extends Area2D
class_name MapLocation


var loc_name: String = "Beach"
var switchTo: SceneManager.Scene = SceneManager.Scene.BEACH
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact():
	print("Location Node has been interacted with: Function node name is" + "")
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass



func _on_body_entered(body: Node2D) -> void:
		if body is MapFish:
				body.add_hovering(self)

func _on_body_exited(body: Node2D) -> void:
		if body is MapFish:
				body.remove_hovering(self)
