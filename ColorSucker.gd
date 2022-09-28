extends Node2D

export (PackedScene) var DesaturateSprite
export var radius := 256


var desaturation_material = preload("res://desaturation/desaturate_material.tres")

var desaturate_nodes: Array = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tick = 0
var node_holder : Node2D
var current_scene : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	node_holder = get_tree().current_scene.find_node("DesaturationHolder")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick += 1
	if tick % 30 == 0:
		var desaturation_sprite = DesaturateSprite.instance()
#		desaturation_sprite.texture = mask
		desaturation_sprite.material = desaturation_sprite.material.duplicate()
		desaturation_sprite.global_position = global_position
		desaturation_sprite.rotation = rand_range(-PI, PI)
		
		get_tree().current_scene.add_child_below_node(node_holder, desaturation_sprite)
