extends Button

func _on_pressed():
	if get_child_count() == 0:
		var settings_window = load("res://scenes/settings_window.tscn").instantiate()
		settings_window.position = Vector2(100, 100)
		add_child(settings_window)
