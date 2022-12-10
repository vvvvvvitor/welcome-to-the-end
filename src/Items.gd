extends Node3D

@onready var camera = get_viewport().get_camera_3d()
@onready var offset = $Offset
@onready var inventory = $".."

func _process(delta):
	global_rotation.y = lerp_angle(global_rotation.y, camera.global_rotation.y, 0.2)
	global_rotation.x = lerp_angle(global_rotation.x, camera.global_rotation.x, 0.2)

func _physics_process(delta):
	global_position = lerp(global_position, camera.global_position, 0.3)
	if is_instance_valid(inventory.selected_item):
		if inventory.selected_item:
			offset.position.z = -(inventory.selected_item.scale.z)
