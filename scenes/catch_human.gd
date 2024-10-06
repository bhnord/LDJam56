extends Node2D


var START_GRACE = 2;
var start_timer = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	start_timer += delta;
	
	if(delta > START_GRACE):
		rotate(delta)
		
	pass

#
#func rotate(delta):
	#rotation
