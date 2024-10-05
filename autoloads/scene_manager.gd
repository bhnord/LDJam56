extends Node

var current_scene = null

enum Scene {PULLING_ROD, BEACH}
var scenes = ["res://scenes/PullingRod.tscn", "res//scenes/Beach.tscn"]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	var scene_name = current_scene.get_name()

func switch_to_scene(scene:Scene):
	call_deferred("_deferred_switch", scenes[scene])
	

func _deferred_switch(res_path):
	current_scene.free()
	var new_s = load(res_path)
	current_scene = new_s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
