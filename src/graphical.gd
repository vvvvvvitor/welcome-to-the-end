extends Node

@onready var env = $Env


var ssr:bool = true:
	get: return ssr
	set(value):
		ssr = value
		env.environment.ssr_enabled = ssr

var bloom:bool = true:
	get: return bloom
	set(value):
		bloom = value
		env.environment.glow_enabled = bloom

var ssil:bool = true:
	get: return ssil
	set(value):
		ssil = value
		env.environment.ssil_enabled = ssil
