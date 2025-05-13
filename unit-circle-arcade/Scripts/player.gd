extends CharacterBody2D


@export var SPEED = 400.0
@export var JUMP_VELOCITY = -600.0
@export var DASH_VELOCITY = 2000
@onready var coyote_time = $"Coyote Time"
@export var player : int
var double_jump_ready = false
var dash_ready = false
var coyote_ready = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Add more velocity if down is being pressed
	if Input.is_action_just_pressed("Down P"+str(player)):
		velocity.y = -JUMP_VELOCITY*2
	
	# If not on floor, start the coyote time timer
	if not is_on_floor() and coyote_ready:
		coyote_ready = false
		coyote_time.start()
	# If on floor, reset the coyote time timer and the dash
	if is_on_floor():
		coyote_time.stop()
		coyote_ready = true
		dash_ready = true

	# Handle jump.
	if Input.is_action_just_pressed("Red P"+str(player)) and (on_floor() or double_jump_ready):
		coyote_ready=false
		velocity.y = JUMP_VELOCITY
		if(on_floor()): double_jump_ready=true
		else: double_jump_ready=false
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left P"+str(player), "Right P"+str(player))
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Handle dash.
	if Input.is_action_just_pressed("Blue P"+str(player)) and dash_ready:
		velocity.x += DASH_VELOCITY*direction
		dash_ready = false

	move_and_slide()

func on_floor() -> bool:
	return is_on_floor() or coyote_time.time_left>0
