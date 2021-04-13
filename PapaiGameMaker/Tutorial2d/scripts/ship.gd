extends Node2D

const PRE_LAZER = preload("res://scenes/lazer.tscn")

export var vel = 100.0
export(NodePath) var lazeres

const METEORO_COLLISION_LAYER_VALUE = 4
var escudo = 100.0

onready var escudo_size = $escudo/sprite.material.get_shader_param("size")
onready var shape_size = $area/shape.shape.radius

#posicao mínima esquerda 21

func _ready():
	if lazeres:
		lazeres = get_node(lazeres)
	else:
		lazeres = get_parent()

func _process(delta):
	
	var dirX = 0
	var dirY = 0
	
	if Input.is_action_pressed("ui_left"):
		dirX += -1
		
	if Input.is_action_pressed("ui_right"):
		dirX += 1
		
	if Input.is_action_pressed("ui_up"):
		dirY += -1
		
	if Input.is_action_pressed("ui_down"):
		dirY += 1
		
	if Input.is_action_just_pressed("ui_accept"):
		if (get_tree().get_nodes_in_group("lazeres").size() < 7):
			var lazer = PRE_LAZER.instance()
			lazeres.add_child(lazer)
			lazer.global_position = $blaster.global_position
	
	translate(Vector2(dirX, dirY) * vel * delta)
	
	global_position.x = clamp(global_position.x, 21, 139)
	global_position.y = clamp(global_position.y, 24, 266)
	
	pass


func _on_area_area_entered(area):
	
	if area.get_parent().has_method("destroy"):
		area.get_parent().destroy()
	
	if [METEORO_COLLISION_LAYER_VALUE].find(area.collision_layer) >= 0:
		get_tree().call_group("camera", "treme", 1)
		escudo -= .5
		var proporcao = escudo / 100.0
		$area/shape.shape.radius = shape_size * proporcao
		$escudo/sprite.material.set_shader_param("size", escudo_size * proporcao)


func _on_dead_area_area_entered(area):
	visible = false
	set_process(false)
	pass # Replace with function body.
