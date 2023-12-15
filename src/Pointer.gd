extends CenterContainer

@onready var camera = get_viewport().get_camera_3d()
@onready var cursor = $Cursor
@onready var item_name = $ItemName

func _ready():
	camera.pick_changed.connect(_on_pick_change)


var i = ""
func _on_pick_change(item):
	var scale_tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)

	if item != null:
		item_name.text = item.item_name
		scale_tween.tween_property(cursor, 'custom_minimum_size', Vector2(len(item.item_name) * 12, 22), 0.1).set_ease(Tween.EASE_OUT)
	else:
		scale_tween.tween_property(cursor, 'custom_minimum_size', Vector2(22, 22), 0.1).set_ease(Tween.EASE_IN_OUT)
		item_name.text = ''
