extends KinematicBody2D

var can_move = true
var player = null
var move_distance = 0
var speed = 90
var direction = Vector2.ZERO
var change_direction = true
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _physics_process(delta):
	
	print(move_distance)
	
	if move_distance == 0:
		if player != null:
			direction = player.global_position - global_position
		else:
			if change_direction == true:
				direction.x = rand_range(-1,1)
				direction.y = rand_range(-1,1)
				change_direction = false
				$Change_direction_timer.wait_time = rng.randi_range(3,5)
				$Change_direction_timer.start()
	
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

func move():
	move_and_slide(direction.normalized() * speed)
	move_distance -= speed
