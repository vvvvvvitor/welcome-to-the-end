extends HBoxContainer

@onready var check_box = $CheckBox
@export var option_name:String

@onready var value:
	get: return value
	set(new_value):
		value = new_value

@onready var title = $Title
var id:int = 0

func _ready():
	title.text = option_name
	check_box.button_pressed = value

func _on_check_box_toggled(button_pressed):
	value = !button_pressed
	print(value)
	get_parent().update_settings(id, value)
