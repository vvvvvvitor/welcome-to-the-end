extends Item


# Called when the node enters the scene tree for the first time.
func _ready():
	item_name = 'Energy Bar'
	item_used.connect(_on_item_use)

func _on_item_use():
	if owned_by is Player:
		owned_by.stamina += 10
		queue_free()
