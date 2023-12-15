extends Node

@onready var actor = get_parent()

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
	selected_changed.connect(_on_select_change)


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

	if event.is_action_pressed("inventory_drop"):
		if selected_item != null:
			drop_item(selected_item, -get_viewport().get_camera_3d().basis.z)
			selected_item = null


func drop_item(item, direction):
	if !wall_ray.is_colliding():
		if item.dropped == false:
			item.dropped = true
			item.position = items.global_position
			item.rotation = get_viewport().get_camera_3d().global_rotation
			item.owned_by = null
			item.apply_impulse(direction * 3)
			items.remove_child(item)
			get_tree().get_current_scene().add_child(item)


func add_item(item):
	item.get_parent().remove_child(item)
	items.add_child(item)
	item.owned_by = actor
	item.dropped = false
	item.position = Vector3.ZERO
	item.rotation = Vector3.ZERO


func _on_child_enter(node):
	selected_item = node


func _on_select_change(item):
	if item:
		item.tree_exiting.connect(_on_selected_exit)


func _on_selected_exit():
	if selected_item != null:
		if !selected_item.dropped:
			selected_item = null
