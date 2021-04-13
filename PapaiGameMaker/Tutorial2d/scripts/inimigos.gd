extends Node2D

const PRE_ASTEROID = preload("res://scenes/asteroid.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")
const PRE_CRISTAL = preload("res://scenes/cristal.tscn")

func _ready():
	restartTimer()
	pass

func _process(delta):
	pass

func _on_spawn_timer_timeout():
	var asteroid = create_asteroid()
	add_child(asteroid)
	asteroid.global_position = Vector2(rand_range(40, 120), -60)
	restartTimer()

func restartTimer():
	$spawn_timer.wait_time = rand_range(.5, 3)
	$spawn_timer.start()

func on_asteroid_destroyed(asteroid):
	
	if (asteroid.chosen >= 3):
		for a in range(randi() % 2 + 2):
			var new_asteroid = create_asteroid()
			new_asteroid.chosen = (randi() % 2) + 1
			add_child(new_asteroid)
			new_asteroid.global_position = asteroid.global_position
			
	get_tree().call_group("hud", "asteroid_destroyed", asteroid)
	
	var explosion = PRE_EXPLOSION.instance()
	add_child(explosion)
	explosion.global_position = asteroid.global_position
	
	for a in range(asteroid.get_hp_inicial()):
		var c = PRE_CRISTAL.instance()
		add_child(c)
		c.global_position = asteroid.global_position
	
	pass

func create_asteroid():
	var asteroid = PRE_ASTEROID.instance()
	asteroid.connect("destroyed", self, "on_asteroid_destroyed")
	return asteroid
