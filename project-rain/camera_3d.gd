extends Camera3D

@export var target: Node3D               # The node to orbit (e.g., your player)
@export var sensitivity: float = 0.005    # Mouse sensitivity
@export var distance: float = 10.0        # Desired distance from the target
@export var min_pitch: float = -1.2       # Minimum pitch in radians (approx -70°)
@export var max_pitch: float = 1.2        # Maximum pitch in radians (approx 70°)
@export var smooth_speed: float = 8.0     # How fast the camera smooths to the desired position

var yaw: float = 0.0
var pitch: float = 0.0

func _ready() -> void:
	# Capture the mouse for camera control.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Update yaw and pitch based on mouse movement.
		yaw -= event.relative.x * sensitivity
		pitch -= event.relative.y * sensitivity
		# Clamp the pitch to avoid flipping over.
		pitch = clamp(pitch, min_pitch, max_pitch)

func _process(delta: float) -> void:
	if not target:
		return

	# Calculate the desired offset from the target using spherical coordinates.
	var offset: Vector3 = Vector3(
		distance * cos(pitch) * sin(yaw),
		distance * sin(pitch),
		distance * cos(pitch) * cos(yaw)
	)
	# Desired camera position is target position plus the offset.
	var desired_position: Vector3 = target.global_transform.origin + offset
	
	# Smoothly interpolate the camera's position to the desired position.
	global_transform.origin = global_transform.origin.lerp(desired_position, smooth_speed * delta)
	
	# Ensure the camera always looks at the target.
	look_at(target.global_transform.origin, Vector3.UP)
