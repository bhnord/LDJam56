extends Node2D

signal beat_finished

var speed = 100
var target_position
var disappear_time = .2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#TODO This prolly shouldnt be hard coded like this
	add_to_group("beats")
	target_position = Vector2(get_viewport_rect().size[0]/2, get_viewport_rect().size[1] - 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = (target_position - position).normalized();
	var old_pos = position
	position += direction * speed * delta;
	if position.distance_to(target_position) < 40:
		$DisappearTimer.start(disappear_time)
		set_process(false)
		
func _on_disappear_timer_timeout():
	emit_signal("beat_finished")
	queue_free()
