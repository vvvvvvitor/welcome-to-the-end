extends Button

@onready var menu = $"../../../.."
@onready var game = $"../../../../../Game"


func _on_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	menu.visible = false
	game.visible = true
