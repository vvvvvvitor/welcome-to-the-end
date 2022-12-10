extends Control

@onready @export var inventory:Node = get_viewport().get_camera_3d().inventory

@onready var items = null
@onready var slots = $VBox/Slots
@onready var item_name = $VBox/ItemName


func _ready():
	inventory = get_viewport().get_camera_3d().inventory
	items = inventory.get_node('Items').get_node('Offset')
	
	make_slots()
	
	inventory.selected_changed.connect(_on_select_change)
	items.child_exiting_tree.connect(_on_item_exited)
	items.child_entered_tree.connect(_on_item_entered)


func make_slots():
	for item in items.get_children():
		var new_slot = load("res://scenes/item_panel.tscn").instantiate()
		new_slot.reference = item
		new_slot.picture = item.picture
		slots.add_child(new_slot)


func _on_select_change(item):
	print(slots.get_children())
	for slot in slots.get_children():
		slot.selected = slot.reference == item
		if item != null:
			item_name.text = item.item_name
		else: item_name.text = ''
		


func _on_item_exited(item):
	for slot in slots.get_children():
		if slot.reference == item:
			slot.queue_free()


func _on_item_entered(item):
	for slot in slots.get_children():
		slot.queue_free()
	
	make_slots()
	
	for slot in slots.get_children():
		slot.selected = slot.reference == item
