extends Node2D

var chosen = 0
var hp = 0

onready var velY = rand_range(30, 100)
onready var velX = rand_range(-50, 50)

var knockback = 0

signal destroyed(node)

var hps = [
	2,
	2,
	4,
	3,
	3
]

func _ready():
	randomize()
	for a in $asteroids.get_children():
		a.visible = false
	
	if not chosen:
		chosen = (randi() % $asteroids.get_child_count()) + 1
	
	hp = hps[chosen - 1]
	
	var chosen_asteroid = get_node("asteroids/asteroid-" + str(chosen))
	
	chosen_asteroid.visible = true
	
	$area/shape.shape.radius = chosen_asteroid.texture.get_width() / 2
	
	pass # Replace with function body.

func _process(delta):
	translate(Vector2(velX, velY - knockback) * delta)
	
	if global_position.x > 200:
		global_position.x = -40
	elif global_position.x < -40:
		global_position.x = 200
	
	if global_position.x > 300:
		global_position.y = -60
	
	if knockback:
		knockback = lerp(knockback, 0, .1)
	pass


func _on_area_area_entered(area):
	hp -= 1
	knockback = 100
	
	if not hp:
		destroy()
	else:
		get_tree().call_group("camera", "treme", .5)
	pass # Replace with function body.

func destroy():
	get_tree().call_group("camera", "treme", 1)
	emit_signal("destroyed", self)
	queue_free()

func get_hp_inicial():
	return hps[chosen - 1]

