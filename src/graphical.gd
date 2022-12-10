extends Node

@onready var env = get_tree().get_first_node_in_group('env').get_environment()


var ssr:bool = true:
	get: return ssr
	set(value):
		ssr = value
		env.ssr_enabled = ssr

var bloom:bool = true:
	get: return bloom
	set(value):
		bloom = value
		env.glow_enabled = bloom

var ssil:bool = true:
	get: return ssil
	set(value):
		ssil = value
		env.ssil_enabled = ssil
