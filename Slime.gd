extends KinematicBody2D

var can_move = true
var player = null
var move_distance = 0
var speed = 90
var direction = Vector2(0,0)
var change_direction = true
var can_change_direction = true
var rng = RandomNumberGenerator.new()


onready var animationTree = $AnimationTree


func _ready():
	can_move()
	rng.randomize()
	animationTree.active = true

func _physics_process(delta):
	
#	print(can_change_direction)
	
	if move_distance == 0 and can_change_direction:
		can_change_direction = false
		if player != null:
			direction = player.global_position - global_position
			animationTree.set("parameters/Move/blend_position", direction)
		else:
			if change_direction == true:
				direction.x = rng.randf_range(-1,1)
				direction.y = rng.randf_range(-1,1)
				change_direction = false
				$Change_direction_timer.wait_time = rng.randi_range(3,5)
				$Change_direction_timer.start()
				animationTree.set("parameters/Move/blend_position", direction)
	
	if move_distance != 0:
		move()




func _on_Player_detector_body_entered(body):
	player = body

func _on_Player_detector_body_exited(body):
	player = null

func _on_Change_direction_timer_timeout():
	change_direction = true

func can_move():
	move_distance = 1800


func animtion_finished():
	can_change_direction = true
	animationTree.active = false
	$animation_delay.start()

func move():
	move_and_slide(direction.normalized() * speed)
	move_distance -= speed


func _on_animation_delay_timeout():
	$AnimationTree.active = true
