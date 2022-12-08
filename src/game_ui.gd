extends ReferenceRect

@onready var camera = get_viewport().get_camera_3d()
@onready @export var target:CharacterBody3D = get_viewport().get_camera_3d().target
@onready var stamina = $TopBar/HBoxContainer/Panel/MarginContainer/Stamina
@onready var cursor = $Pointer/Cursor

signal game_ui_visible_changed
var ui_visible:bool = false:
	get: return ui_visible
	set(value):
		if ui_visible != value:
			emit_signal('game_ui_visible_changed', value)
		ui_visible = value
		
		
func _ready():
	game_ui_visible_changed.connect(_on_visible_change)
	camera.can_pick_changed.connect(_on_pick_change)

func _process(delta):
	stamina.value = target.get('stamina')
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if target is CharacterBody3D:
			ui_visible = (target.velocity.length() > 0.8 && target.velocity.length() < 5) 

func _on_visible_change(value):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	
	if ui_visible:
		tween.tween_property(self, 'modulate', Color(1, 1, 1, 1), 0.5).set_ease(Tween.EASE_IN)
	else: tween.tween_property(self, 'modulate', Color(0, 0, 0, 0), 0.5).set_ease(Tween.EASE_IN_OUT)


func _on_pick_change(value):
	var scale_tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)
	
	if value:
		scale_tween.tween_property(cursor, 'custom_minimum_size', Vector2(33, 22), 0.1).set_ease(Tween.EASE_OUT)
	else: scale_tween.tween_property(cursor, 'custom_minimum_size', Vector2(22, 22), 0.1).set_ease(Tween.EASE_IN_OUT)
