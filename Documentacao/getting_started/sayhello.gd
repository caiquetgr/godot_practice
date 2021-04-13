extends Panel

func _ready():
	get_node("Botao").connect("pressed", self, "_on_Botao_pressed")
	
func _on_Botao_pressed():
	get_node("Label").text = "HELLO"
