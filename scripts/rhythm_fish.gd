extends CharacterBody2D

const END_MARGIN = 80;

# Movement variables
var base_speed = -10.0  # Slight constant leftward movement
var max_speed = 100.0  # Maximum speed in either direction

var boost_foward = -60.0;
# Knockback variables
var knockback_strength = 700.0/(GameManager.mouth+1)
var knockback_duration = 0.2
var knockback_timer = 0.0


# Screen boundaries
var screen_size
#
func _ready():
	get_tree().get_root().size_changed.connect(resize) 
	resize()

func is_game_over():
	if is_at_win():
		print("WIN")
		SceneManager.end_rhythm(true)
	elif is_at_loss():
		SceneManager.end_rhythm(false)
		print("LOSS")
	
	

func setSettings():
	var level = GameManager.human_opponent.LEVEL
	var fins = GameManager.fins
	knockback_strength = ((700.0/(GameManager.mouth+1)) * (1.25 * level))
	boost_foward = (-60.0 + (12.0 * level) + (fins * 4.0))
	max_speed = 75 + (fins * 6)
	base_speed = -10 + level
	

func is_at_win():
	return global_position.x <= -1 * screen_size.x/2.0 + END_MARGIN
	
func is_at_loss():
	return global_position.x >= screen_size.x/2.0 - END_MARGIN

func resize():
	screen_size = get_viewport_rect().size
	position = Vector2(position.x, screen_size[1]/2)

func _physics_process(delta):
	if knockback_timer > 0:
		apply_knockback_movement(delta)
	else:
		apply_normal_movement(delta)
	
	# Reset position if fish goes off-screen
	#if position.x < -100:  # Allow some leeway before resetting
		#position.x = screen_size.x + 50  # Appear slightly off-screen to the right
	#elif position.x > screen_size.x + 100:
		#position.x = -50  # Appear slightly off-screen to the left
	
	# Apply the movement
	move_and_slide()

func apply_knockback_movement(delta):
	var t = 1 - (knockback_timer / knockback_duration)
	var eased_strength = knockback_strength * (1 - t * t)  # Quadratic easing out
	velocity.x = eased_strength  # Knockback is always to the right
	knockback_timer -= delta
	if knockback_timer <= 0:
		velocity.x = base_speed  # Reset to base speed after knockback

func apply_normal_movement(delta):
	# Gradually return to base speed
	velocity.x = move_toward(velocity.x, base_speed, 100 * delta)

func apply_knockback():
	knockback_timer = knockback_duration

func boost_forward(boost_strength: float):
	velocity.x = min(velocity.x + boost_strength, max_speed)

# Function to be called from parent node
func handle_hit():
	boost_forward(boost_foward )  # Adjust boost strength as needed

# Function to be called from parent node
func handle_miss():
	apply_knockback()
