extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var score: = 100

func _on_body_entered(body: Node2D) -> void:
	picked()

func picked() -> void:
	PlayerData.score += score
	anim_player.play("fade_out");
