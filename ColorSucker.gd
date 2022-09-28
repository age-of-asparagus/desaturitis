extends Node2D

export (PackedScene) var DesaturateSprite
export var size := 64.0
export var seconds := 0.3


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
	node_holder = get_or_create_holder()
	current_scene = get_tree().current_scene
	$Particles2D.process_material.set("emission_ring_radius", size/2)
	$Particles2D.process_material.set("emission_ring_inner_radius", size/2.5)
	
	suck_color()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick += 1
	if tick % int(seconds*10) == 0:
		tick = 0
#		suck_color()

		
func suck_color():
	var desaturation_sprite = DesaturateSprite.instance()
	var scale = size / desaturation_sprite.texture.get_width()
	desaturation_sprite.scale = Vector2(scale, scale)
	desaturation_sprite.material = desaturation_sprite.material.duplicate()
	desaturation_sprite.global_position = global_position
	desaturation_sprite.rotation = rand_range(-PI, PI)
	
	$Timer.start()
	$Particles2D.emitting = true
	node_holder.add_child(desaturation_sprite)

func get_or_create_holder():
	node_holder = get_tree().current_scene.find_node("DesaturationHolder")
	
	# if doesn't exist, then node_holder will be null
	if node_holder == null:
		# then we have to create it
		node_holder = Node2D.new()
		node_holder.name = "DesaturationHolder"
		
		# Need to defer because not everything is ready yet and
		# get an error if using add_child here
		get_tree().current_scene.call_deferred("add_child", node_holder)
		
		# we want to place the holder BEFORE the YSort, if one exists
		var ysort = get_tree().current_scene.find_node("YSort")
		if ysort: # exists otherwise would be null
			# place at ysort index, that should bump the ysort down
			get_tree().current_scene.call_deferred("move_child", node_holder, ysort.get_index())
		
	return node_holder


func _on_Area2D_area_exited(area):
	# should only detect DesaturationSprites
	# make sure we aren't already in an sprite
	if $Area2D.get_overlapping_areas().size() == 0:
		suck_color()



func _on_Timer_timeout():
	print("stopped")
	$Particles2D.emitting = false
