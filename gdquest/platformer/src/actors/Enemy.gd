extends "res://src/actors/Actor.gd"

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_stomp_detector_body_entered(body: PhysicsBody2D) -> void:
	print("colidiu")
	print("Body: " + str(body.global_position.y) + " / Stomp detector: " + str($stomp_detector.global_position.y))
	if body.global_position.y > $stomp_detector.global_position.y:
		return
	
	print("deveria morrer")
	#$CollisionShape2D.disabled = true
	
	queue_free()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	if is_on_wall():
		_velocity.x *= -1.0
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

