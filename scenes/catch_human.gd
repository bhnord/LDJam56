extends Node2D

func _ready() -> void:
	if not GameManager.human_opponent:
		print("NO HUMAN OPPONENT DEFAULTING MODEL")
		$CanvasLayer/HBoxContainer/Control/Fisherman.texture = load("res://sprites/fishmen/fishman_1.png")
	else:
		var texture_path = "res://sprites/fishmen/fishman_1.png"
		
		match GameManager.human_opponent.LEVEL:
			1:
				texture_path = "res://sprites/fishmen/fishman_1.png"
			2:
				texture_path = "res://sprites/fishmen/fishman_2.png"
			3:
				texture_path = "res://sprites/fishmen/fishman_3.png"
			_:
				print("WARN NO FISHERMAN FOR DIFFICULT", GameManager.human_opponent.PULL_LVL)
				texture_path = "res://sprites/fishmen/fishman_1.png"

		$CanvasLayer/HBoxContainer/Control/Fisherman.texture = load(texture_path)
	
	var animation_player = $CanvasLayer/HBoxContainer/Control/Fisherman/AnimationPlayer
	animation_player.connect("animation_finished", _on_animation_finished)
	animation_player.play("plop")
	

func _process(delta: float) -> void:
	pass

func _on_animation_finished(anim_name: String) -> void:
	SceneManager.end_win_animation()
