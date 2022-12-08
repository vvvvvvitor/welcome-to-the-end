extends VBoxContainer

@export var options:Array[Dictionary] = [
	{'name': 'Screen Space Reflections Disabled', 'target': Settings, 'property': 'ssr', 'value': !Settings.get('ssr'), 'id': 0},
	{'name': 'Bloom Disabled', 'target': Settings, 'property': 'bloom', 'value': !Settings.get('bloom'), 'id': 1},
	{'name': 'SSIL Disabled', 'target': Settings, 'property': 'ssil', 'value': !Settings.get('ssil'), 'id': 2}
]

func _ready():
	make_options()

func make_options():
	for option in options:
		var new_option = load("res://scenes/option.tscn").instantiate()
		new_option.option_name = option['name']
		new_option.id = option['id']
		new_option.value = option['value']
		add_child(new_option)
		print(Settings.env.get('environment/glow_enabled'))

func update_settings(id, value):
	for option in options:
		if id == option['id']:
			option['target'].set(option['property'], value)
			option['value'] = value
			break
