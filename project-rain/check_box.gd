extends CheckBox

@onready var sound_player = $AudioStreamPlayer  # Reference the sound player

func _ready() -> void:
	# Connect the checkbox "toggled" signal to the function
	toggled.connect(_on_checkbox_toggled)

func _on_checkbox_toggled(button_pressed: bool) -> void:
	if button_pressed:  # Only play the sound when checked
		if sound_player and sound_player.stream:
			sound_player.play("res://light-rain-by-liecio-from-pixabay.mp3")
	print(button_pressed)  # Print true (checked) or false (unchecked)

	
