extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 10.0
@export var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_paused: bool = false
var pause_menu: Control  # Changed from CanvasLayer to Control

func _ready() -> void:
	# Ensure the game starts unpaused
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Lock the mouse at the start

	# Load and instance the pause menu scene
	var pause_scene = load("res://pause_menu.tscn")
	if pause_scene:
		pause_menu = pause_scene.instantiate() as Control  # Correctly cast to Control
		# Defer adding the pause menu until the parent is ready
		get_tree().root.call_deferred("add_child", pause_menu)
		pause_menu.hide()  # Hide it at the start

func _physics_process(delta: float) -> void:
	if is_paused:
		return  # Skip movement processing when paused

	# Determine movement direction based on input actions.
	var input_direction: Vector3 = Vector3.ZERO
	if Input.is_action_pressed("Move Forward"):
		input_direction.z -= 1
	if Input.is_action_pressed("Move Backward"):
		input_direction.z += 1
	if Input.is_action_pressed("Move Left"):
		input_direction.x -= 1
	if Input.is_action_pressed("Move Right"):
		input_direction.x += 1
	input_direction = input_direction.normalized()

	# Set horizontal velocity.
	velocity.x = input_direction.x * speed
	velocity.z = input_direction.z * speed

	# Jumping and gravity.
	if is_on_floor():
		print("Player is on the floor") 
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jump_velocity
	else:
		print("Player is in the air")
		# Apply gravity if not on the floor.
		velocity.y -= gravity * delta

	# Move the character based on the velocity.
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		toggle_pause()

func toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = is_paused

	# Show or hide the pause menu and update mouse behavior
	if pause_menu:
		if is_paused:
			pause_menu.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Allow free mouse movement
		else:
			pause_menu.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Capture mouse back into game
