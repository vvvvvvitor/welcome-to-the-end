extends Node3D

@onready var camera = get_viewport().get_camera_3d()
@export var offset:Vector3 = Vector3(0.2, -1, -1)
@onready var item:Node3D

func _process(delta):
	if item != null:
		global_rotation.y = lerp_angle(global_rotation.y, camera.global_rotation.y, 0.2)
		global_rotation.x = lerp_angle(global_rotation.x, camera.global_rotation.x, 0.2)

func _physics_process(delta):
	if item != null:
		global_position = lerp(global_position, camera.global_position, 0.3)
		item.position = offset


func _on_child_entered_tree(node):
	item = node


func _on_child_exiting_tree(node):
	item = null
