extends Window
class_name VTWindow


func _ready():
	visible = get_parent().visible
	
	close_requested.connect(on_close_request)
	get_parent().visibility_changed.connect(on_parent_visibility_change)

	var tween = get_tree().create_tween()
	tween.stop()
	tween.tween_property(self, 'size', size, 0.1).set_trans(tween.TRANS_QUAD).set_ease(tween.EASE_OUT)
	size = Vector2.ZERO
	tween.play()


func on_close_request():
	queue_free()

	
func on_parent_visibility_change():
	if visible:
		queue_free()
