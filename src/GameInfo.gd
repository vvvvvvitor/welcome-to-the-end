extends Node

@onready var commit_info = $UI/Box/Margin/CommitInfo

# Called when the node enters the scene tree for the first time.
func _ready():
	var output = []
	var formatted_output:String
	
	OS.execute("git", ['log', -1], output)
	
	for item in output:
		formatted_output += item
	commit_info.text = formatted_output
