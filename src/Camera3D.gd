extends Camera3D

@export var target:Node3D

@export_range(0, 1) var sensitivity:float = 0.01

@onready var menu = $UI/Menu
@onready var game = $UI/Game
@onready var pick_ray = $PickRay

signal can_pick_changed
var can_pick:bool = false:
	get: return can_pick
	set(value):
		if can_pick != value:
			emit_signal('can_pick_changed', value)
		
		can_pick = value

@onready @export var inventory:Node

func _input(event):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.x -= event.relative.y * sensitivity
			rotation.y -= event.relative.x * sensitivity
			rotation.x = clamp(rotation.x, (-PI / 2) * 0.9, (PI / 2) * 0.9)
			
	if event is InputEvent:
		if event.is_action_pressed('menu_back'):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: 
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

			menu.visible = Input.mouse_mode != Input.MOUSE_MODE_CAPTURED
			game.ui_visible = !Input.mouse_mode == Input.MOUSE_MODE_CAPTURED

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	position = target.position + Vector3(0, target.scale.y * 0.5, 0)

	
	var detected = pick_ray.get_collider()
	if detected:
		if detected is Item:
			can_pick = true
			if Input.is_action_just_pressed("action_secondary"):
				detected.get_parent().remove_child(detected)
				inventory.items.add_child(detected)
				detected.dropped = false
				detected.position = Vector3.ZERO
				detected.rotation = Vector3.ZERO
	else: can_pick = false
