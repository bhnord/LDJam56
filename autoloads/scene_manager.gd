extends Node

var current_scene = null
var curr_scene_path = ""
enum Scene {PULLING_ROD, BEACH, END_OF_DAY, SHOP, BOAT, PIER}
var scenes = ["res://scenes/rhythm/Rhythm.tscn", "res://scenes/Beach.tscn", "res://scenes/EndOfDay.tscn", "res://scenes/Shop.tscn", "res://scenes/Boat.tscn", "res://scenes/Pier.tscn"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)

var last_rhythm_scene= ""
func switch_to_scene(scene:Scene):
	if scene == Scene.PULLING_ROD:
		last_rhythm_scene=current_scene.scene_file_path
	call_deferred("_deferred_switch", scenes[scene])
	
func end_rhythm(win: bool):
	if(win):
		GameManager.add_money(GameManager.human_opponent.WORTH)
	else:
		GameManager.subtract_money((int)(.25 * GameManager.human_opponent.WORTH))
	call_deferred("_deferred_switch",last_rhythm_scene)
	
func _deferred_switch(res_path):
	current_scene.free()
	var new_s = load(res_path)
	current_scene = new_s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
var map = "res://scenes/Map/Map.tscn"

func open_map():
	call_deferred("_deferred_switch", map)

var shop = "res://scenes/Shop.tscn"
var shop_last_scene = null
var shop_open = false
func toggle_shop():
	if not shop_open:
		shop_open = true
		shop_last_scene = current_scene.scene_file_path
		call_deferred("_deferred_switch", shop)
	else:
		shop_open = false
		call_deferred("_deferred_switch", shop_last_scene)
	
	
		
	
