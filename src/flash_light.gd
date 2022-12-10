extends Item

@export var toggled:bool = false

@export var energy_burst:float = 22
@export var turned_on_energy = 2.5
@onready var toggle_timer = $ToggleTimer
@onready var point_light = $PointLight

func _ready():
	item_name = 'Flashlight'
	if toggled:
		point_light.light_energy = turned_on_energy
	else: point_light.light_energy = 0
	
	item_used.connect(_on_item_use)

func _on_item_use():
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if toggle_timer.is_stopped():
			toggled = !toggled
			toggle(energy_burst, !toggled)
			toggle_timer.start()

func toggle(flash_value, reverse_bool:bool = false) -> void:
	point_light.light_energy = flash_value
	var toggle_tween = get_tree().create_tween()

	if reverse_bool:
		toggle_tween.tween_property(point_light, 'light_energy', 0, 0.2)
		await toggle_tween.finished
		point_light.visible = false
	else:
		point_light.visible = true
		toggle_tween.tween_property(point_light, 'light_energy', turned_on_energy, 0.2)
