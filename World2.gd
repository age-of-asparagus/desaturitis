extends Node2D

onready var DesatureateCircle = preload("res://DesaturateCircle.tscn")

var click_pos: Array = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tick = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick += 1
	if tick % 15 == 0:
		var circle = DesatureateCircle.instance()
		circle.position = $YSort/Player.global_position
		add_child(circle)

func _input(event: InputEvent):
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		return
		
	print("Clicking")
	click_pos.append(event.position)
	update()
	
func _draw():
	print("drawing")
	for point in click_pos:
		print(click_pos)
		draw_circle(point, 10, Color.red)
