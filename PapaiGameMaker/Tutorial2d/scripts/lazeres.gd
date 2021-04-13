extends Node2D

export (NodePath) var nave
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if nave:
		nave = get_node(nave)
	else:
		set_process(false)
	pass # Replace with function body.


func _process(delta):
	global_position.x = (nave.global_position.x - 80) * 0.002 * -160
	pass
