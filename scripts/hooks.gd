extends Node



@export var NUM_HOOKS = 10
@export var DIFFICULTY_LEVEL: int
@export var MIN_MONEY = 10
@export var MAX_MONEY = 40
var hooks_at = []
var hook = preload("res://sprites/hook.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("difficulty: " + str(DIFFICULTY_LEVEL))
	spawn_hooks()



# Called every frame. 'delta' is the elapsed time since the previous frame.
var wait = 0
func _process(delta: float) -> void:
	pass
	##testing
	#wait+=delta
	#if wait > 1:
		#wait=0
		#_add_random_hook()

func spawn_hooks()->void:
	for i in range(NUM_HOOKS):
		_add_random_hook()

#TODO: Fine tune mult to space hooks well
#TODO: Fine tune mod to fit into screen
func _get_rand_in_bounds()->int:
	return (randi()%100)*10

func _add_random_hook():
	var x = _get_rand_in_bounds()
	var y = _get_rand_in_bounds()
	while [x,y] in hooks_at:
		x = _get_rand_in_bounds()
		y = _get_rand_in_bounds()
	_add_hook(x,y)
	hooks_at.append([x,y])
	

func _add_hook(x:int,y:int)->void:
	var object: Hook = hook.instantiate()
	object.human = Human.create(DIFFICULTY_LEVEL)
	call_deferred("add_child", object)
	object.global_position=Vector2(x,y)
	pass
