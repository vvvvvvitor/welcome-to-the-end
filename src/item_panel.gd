extends Panel

@export var picture:Texture2D
@onready var picture_frame = $Margin/Back/Picture

var reference:Item

@export var selected:bool = false:
	get: return selected
	set(value):
		var scale_tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
		selected = value
		scale_tween.stop()
		if selected:
			scale_tween.tween_property(self, 'custom_minimum_size', Vector2(100, 100), 0.2).set_ease(Tween.EASE_OUT)
			scale_tween.play()
		else:
			scale_tween.tween_property(self, 'custom_minimum_size', Vector2(24, 24), 0.2).set_ease(Tween.EASE_IN_OUT)
			scale_tween.play()

func _ready():
	picture_frame.texture = picture
