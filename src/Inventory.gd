extends Node

@onready var ui = $UI
@onready var items = $Items/Offset

@onready var slots = $UI/Margin/Slots
@onready var world_item = $WorldItem

@onready var wall_ray = $Items/WallRay

var input_value:int = 0

signal  selected_changed
var selected_item:Item:
	get: return selected_item
	set(value):
		selected_item = value
		
		for item in items.get_children():
			item.visible = item == selected_item
			item.set_process(item == selected_item)
			item.set_process_input(item == selected_item)

		emit_signal('selected_changed', selected_item)
		
func _ready():
	items.child_entered_tree.connect(_on_child_enter)

func _unhandled_input(event):
	if event is InputEvent:
		if items.get_child_count() != 0:
			if event.is_action_pressed("inventory_scroll_up"):
				input_value += 1
				input_value = clamp(input_value, 0, items.get_child_count() - 1)
				selected_item = items.get_children()[input_value]
			if event.is_action_pressed("inventory_scroll_down"):
				input_value -= 1
				input_value = clamp(input_value, 0, items.get_child_count() - 1)
				selected_item = items.get_children()[input_value]

		if selected_item != null:
			if event.is_action_pressed("inventory_drop"):
				drop_item(selected_item, -get_viewport().get_camera_3d().basis.z)
				

func drop_item(item, direction):
	if !wall_ray.is_colliding():
		if item.dropped == false:
			items.remove_child(item)
			get_tree().get_current_scene().add_child(item)
			item.dropped = true
			item.position = items.global_position
			item.rotation = get_viewport().get_camera_3d().global_rotation
			item.apply_impulse(direction * 3)
			if items.get_child_count() != 0:
				item = items.get_children()[items.get_child_count()]
			else: item == null

func _on_child_enter(node):
	selected_item = node
