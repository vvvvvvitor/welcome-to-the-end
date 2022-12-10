extends RigidBody3D
class_name Item

@onready @export var item_name:String = str(name)
@export var picture:Texture2D
var owned_by

@export var dropped:bool = false:
	get: return dropped
	set(value):
		dropped = value
		freeze = !dropped
		set_process_input(!dropped)
		set_process(!dropped)

func _ready():
	freeze = !dropped
	set_process_input(!dropped)
	set_process(!dropped)
		
signal item_used
func _input(event):
	if event is InputEvent:
		if event.is_action_pressed("action_main"):
			if !dropped:
				emit_signal('item_used')
