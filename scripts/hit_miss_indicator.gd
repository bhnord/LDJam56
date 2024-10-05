extends Node2D

enum HitState {
	MISS,
	HIT,
	TOO_EARLY
}

const MISS_TEXTURE = preload("res://sprites/rhythm/text/miss.png")
const TOO_EARLY_TEXTURE = preload("res://sprites/rhythm/text/too_early.png")
const HIT_TEXTURE = preload("res://sprites/rhythm/text/hit.png")

var duration = 0.6  # Animation duration in seconds
var elapsed_time = 0.0
var initial_position: Vector2
var initial_scale: Vector2
var end_x: float
var hit_state: HitState

@onready var sprite = $Sprite2D  # Assuming you have a Sprite2D node as a child

func init(pos: Vector2, state: HitState) -> void:
	initial_position = pos
	position = initial_position
	hit_state = state

func _ready() -> void:
	initial_position = position
	initial_scale = scale
	end_x = randf_range(-50, 50)
	z_index = 11
	
	# Call set_texture() here, after the node is fully initialized
	set_texture()

func set_texture() -> void:
	if sprite == null:
		push_error("Sprite node not found. Make sure you have a Sprite2D child node.")
		return
	
	match hit_state:
		HitState.MISS:
			sprite.texture = MISS_TEXTURE
		HitState.TOO_EARLY:
			sprite.texture = TOO_EARLY_TEXTURE
		HitState.HIT:
			sprite.texture = HIT_TEXTURE

func _process(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= duration:
		queue_free()
		return
	
	var t = elapsed_time / duration
	
	# Rise effect
	position.y = initial_position.y - 50 * t
	position.x = initial_position.x - end_x * t
	
	# Shrink effect
	var current_scale = 1.0 - 0.5 * t
	scale = initial_scale * current_scale
	
	# Fade out effect
	modulate.a = 1.0 - t
