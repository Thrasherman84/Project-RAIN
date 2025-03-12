extends Control

func _ready() -> void:
	# Wait one frame to ensure nodes are fully loaded
	await get_tree().process_frame

	# Connect button signals safely
	var resume_button = $PanelContainer/VBoxContainer/Resume
	var restart_button = $PanelContainer/VBoxContainer/Restart
	var main_menu_button = $"PanelContainer/VBoxContainer/Main Menu"
	var quit_button = $PanelContainer/VBoxContainer/Quit

	if resume_button:
		resume_button.connect("pressed", Callable(self, "_on_resume_button_pressed"))
	if restart_button:
		restart_button.connect("pressed", Callable(self, "_on_restart_button_pressed"))
	if main_menu_button:
		main_menu_button.connect("pressed", Callable(self, "_on_main_menu_button_pressed"))
	if quit_button:
		quit_button.connect("pressed", Callable(self, "_on_quit_button_pressed"))

	# Ensure the pause menu is hidden initially
	visible = false

func _process(delta: float) -> void:
	# Toggle pause menu visibility when the 'Pause' action is pressed
	if Input.is_action_just_pressed("Pause"):  # 'Escape' key by default
		if visible:
			_resume_game()
		else:
			_pause_game()

func _pause_game() -> void:
	visible = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Show the mouse cursor

func _resume_game() -> void:
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Hide the mouse cursor

func _on_resume_button_pressed() -> void:
	_resume_game()

func _on_restart_button_pressed() -> void:
	_resume_game()  # Unpause first
	await get_tree().create_timer(0.1).timeout  # Small delay to avoid physics glitches
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	_resume_game()
	get_tree().change_scene_to_file("res://main_menu.tscn")  # Go to main menu

func _on_quit_button_pressed() -> void:
	get_tree().quit()  # Exit game
