extends CharacterBody2D

const SPEED = 900.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := -1
@onready var wall_detector := $wall_detector as RayCast2D
@onready var sprite := $sprite as Sprite2D
@onready var animation := $animation as AnimationPlayer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.target_position.x *= -1
		sprite.flip_h = direction != -1
	
	velocity.x = direction * SPEED * delta
	move_and_slide()


func _on_animation_animation_finished(anim_name: StringName):
	if anim_name == "hurt":
		queue_free()
	pass # Replace with function body.
