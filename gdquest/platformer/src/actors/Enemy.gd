extends "res://src/actors/Actor.gd"

export var score: = 100

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_stomp_detector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > $stomp_detector.global_position.y:
		return
	
	$CollisionShape2D.disabled = true
	
	die()

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	if is_on_wall():
		_velocity.x *= -1.0
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	PlayerData.score += score
	queue_free()
