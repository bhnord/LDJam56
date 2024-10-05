extends Area2D
class_name MapLocation


var loc_name: String = "Beach"
var switchTo: SceneManager.Scene = SceneManager.Scene.BEACH
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%LocationName.text = loc_name

func interact():
	print("Location Node has been interacted with: Function node name is" + "")
	SceneManager.switch_to_scene(switchTo)
	



func handleEntered() -> void:
	%LocationName.visible = true;
	
	
func handleExited() -> void:
	%LocationName.visible = false;

func _on_body_entered(body: Node2D) -> void:
		if body is MapFish:
				body.add_hovering(self)
				handleEntered()

func _on_body_exited(body: Node2D) -> void:
		if body is MapFish:
				body.remove_hovering(self)
				handleExited()
