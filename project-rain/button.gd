extends Button

func _ready():
	# Connect the "pressed" signal to the _on_button_pressed function
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	# Change to your main menu scene
	get_tree().change_scene_to_file("res://3D_demo_scene.tscn")
