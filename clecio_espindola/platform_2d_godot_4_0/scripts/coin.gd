extends Area2D

@onready var animation := $animation as AnimatedSprite2D

var collected_animation = "collected"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: Node2D):
	animation.play(collected_animation)


func _on_animation_animation_finished():
	if animation.animation == collected_animation:
		queue_free()
