extends CanvasLayer

var score = 0

func _ready():
	$score.text = str(score)
	pass # Replace with function body.

func _process(delta):
	pass
	
func asteroid_destroyed(asteroid):
	var points = (6 - asteroid.chosen) * 10
	score += points
	$score.text = str(score)
	pass
