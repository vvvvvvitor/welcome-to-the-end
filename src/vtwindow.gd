extends Window
class_name VTWindow


func _ready():
	visible = get_parent().visible
	
	close_requested.connect(on_close_request)
	get_parent().visibility_changed.connect(on_parent_visibility_change)


func on_close_request():
	queue_free()
	
func on_parent_visibility_change():
	if visible:
		queue_free()
