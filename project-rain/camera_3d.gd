extends Camera3D

@export var sensitivity: float = 0.005  # Adjust this value for faster or slower rotation

var yaw: float = 0.0
var pitch: float = 0.0

func _ready():
	# Capture the mouse cursor so that mouse movement is relative.
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Update the yaw and pitch based on the relative mouse movement.
		yaw -= event.relative.x * sensitivity
		pitch -= event.relative.y * sensitivity
		
		# Clamp the pitch to avoid flipping (limits in radians: -PI/2 to PI/2).
		pitch = clamp(pitch, -PI/2, PI/2)
		
		# Set the new rotation using Euler angles.
		rotation = Vector3(pitch, yaw, 0)
