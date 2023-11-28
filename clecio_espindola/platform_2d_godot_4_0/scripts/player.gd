extends CharacterBody2D

const SPEED = 200.0
const JUMP_FORCE = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
@export var life := 10
var knockback_vector := Vector2.ZERO

@onready var animation := $animation as AnimatedSprite2D
@onready var remote_transform := $remote_transform as RemoteTransform2D
@onready var ray_right := $ray_right as RayCast2D
@onready var ray_left := $ray_left as RayCast2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		is_jumping = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if is_jumping:
			animation.play("jump")
		else:
			animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")
		
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector

	move_and_slide()


func _on_hurtbox_body_entered(body: Node2D):
#	if body.is_in_group("enemies"):
#		queue_free()
	if life <= 0:
		queue_free()
	else:
		if ray_left.is_colliding():
			take_damage(Vector2(200, -200))
		elif ray_right.is_colliding():
			take_damage(Vector2(-200, -200))
	
func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	life -= 1
	
	if (knockback_force != Vector2.ZERO):
		knockback_vector = knockback_force
		animation.modulate = Color.RED
		var tween := get_tree().create_tween().parallel()
		tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		tween.tween_property(animation, "modulate", Color.WHITE, duration) 

func follow_camera(camera: Camera2D):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	
func jump():
	velocity.y = JUMP_FORCE
	is_jumping = true
	animation.play("jump")
