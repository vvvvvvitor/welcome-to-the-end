extends RigidBody3D
class_name Item

@export var picture:Texture2D
@export var instance:PackedScene

@export var dropped:bool = false:
	get: return dropped
	set(value):
		dropped = value
		freeze = !dropped
		set_process_input(!dropped)
		set_process(!dropped)
		

func _ready():	
	set_collision_layer_value(2, true)
	set_collision_layer_value(1, true)
