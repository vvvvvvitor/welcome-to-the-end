extends ReferenceRect

@onready var camera = get_viewport().get_camera_3d()
@onready var target:CharacterBody3D = get_viewport().get_camera_3d().target
@onready var stamina = $TopBar/HBoxContainer/PlayerStatus/MarginContainer/Stamina
@onready var player_status = $TopBar/HBoxContainer/PlayerStatus


signal game_ui_visible_changed
var ui_visible:bool = false:
	get: return ui_visible
	set(value):
		if ui_visible != value:
			emit_signal('game_ui_visible_changed', value)
		ui_visible = value


func _ready():
	game_ui_visible_changed.connect(_on_visible_change)

func _process(delta):
	stamina.value = target.get('stamina')

	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if target is CharacterBody3D:
			ui_visible = (target.velocity.length() > 0.8 && target.velocity.length() < 5)

func _on_visible_change(value):
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD)

	if ui_visible:
		tween.tween_property(player_status, 'modulate', Color(1, 1, 1, 1), 0.5).set_ease(Tween.EASE_IN)
	else: tween.tween_property(player_status, 'modulate', Color(0, 0, 0, 0), 0.5).set_ease(Tween.EASE_IN_OUT)
