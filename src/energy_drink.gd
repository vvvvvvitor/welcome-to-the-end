
extends Item

@export var effect_time:int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	item_used.connect(_on_item_use)
	
func _on_item_use():
	if owned_by is Player:
		owned_by.ground_friction = 2
		
	await get_tree().create_timer(effect_time).timeout
	owned_by.ground_friction = 15
	queue_free()
