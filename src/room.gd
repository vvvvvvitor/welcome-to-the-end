extends StaticBody3D

@onready @export var light = $OmniLight3D

signal lights_changed
@export var lights:bool = true:
	get: return lights
	set(value):
		lights = value
		emit_signal('lights_changed', lights)

func _ready():
	lights_changed.connect(_on_lights_changed)
	light.visible = lights

func _on_lights_changed(value):
	light.visible = value
