extends SpotLight3D

@export var toggled:bool = false

@export var energy_burst:float = 22
@export var turned_on_energy = 2.5
@onready var toggle_timer = $ToggleTimer

func _input(event):
	if event is InputEvent:
		if event.is_action_released("action_main"):
			if toggle_timer.is_stopped():
				toggled = !toggled
				toggle(energy_burst, !toggled)
				toggle_timer.start()

func _ready():
	if toggled:
		light_energy = turned_on_energy
	else: light_energy = 0

func toggle(flash_value, reverse_bool:bool = false) -> void:
	light_energy = flash_value
	var toggle_tween = get_tree().create_tween()

	if reverse_bool:
		toggle_tween.tween_property(self, 'light_energy', 0, 0.2)
		await toggle_tween.finished
		visible = false
	else:
		visible = true
		toggle_tween.tween_property(self, 'light_energy', turned_on_energy, 0.2)
