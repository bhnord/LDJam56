extends CharacterBody2D
class_name Fish

@export var move_speed: float=300

var money = 0
var upgrades = null
var nearby_hooks: Array[Hook] = []

func _ready() -> void:
	$CanvasLayer/Money.text = "Coins: " + str(GameManager.money)
	$CanvasLayer/Upgrades.text = "Fins: Level "+str(GameManager.fins) + "\nBooster: Level "+str(GameManager.booster)

func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("right")-Input.get_action_strength("left"),
		Input.get_action_strength("down")-Input.get_action_strength("up")
	)
	
	if Input.is_action_pressed("right"):
		$FishSide.flip_h=false
		$FishTop.visible=false
		$FishSide.visible=true
	elif Input.is_action_pressed("left"):
		$FishSide.flip_h=true
		$FishTop.visible=false
		$FishSide.visible=true
	elif Input.is_action_pressed("down"):
		$FishTop.flip_v=true
		$FishTop.visible=true
		$FishSide.visible=false
	else:
		$FishTop.flip_v=false
		$FishTop.visible=true
		$FishSide.visible=false
		
	velocity=input_direction*move_speed
	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("bite_hook"):
		var hook = nearby_hooks.pop_front()
		if hook:
			hook.interact()
	if Input.is_action_just_pressed("open_map"):
		SceneManager.open_map()
	
	
	
func add_hook(hook:Hook):
	nearby_hooks.push_front(hook)
	
func remove_hook(hook:Hook):
	nearby_hooks.erase(hook)
