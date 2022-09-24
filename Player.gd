extends KinematicBody2D

var acceleration = 0
var max_acceleration = 2
var speed = 25
var velocity = Vector2.ZERO
var moving = false
onready var animationPlayer = $AnimationPlayer
var facing = "right"

func _physics_process(delta):
	
	print(velocity.x)
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("W"):
		velocity.y -= 1
		moving = true
		facing = "up"
		animationPlayer.play("Run_Up")
		
	if Input.is_action_pressed("A"):
		velocity.x -= 1
		moving = true
		facing = "left"
		animationPlayer.play("Run_Left")
		
	if Input.is_action_pressed("D"):
		velocity.x += 1
		moving = true
		facing = "right"
		animationPlayer.play("Run_Right")
		
	if Input.is_action_pressed("S"):
		velocity.y += 1
		moving = true
		facing = "down"
		animationPlayer.play("Run_Down")
		
	if not Input.is_action_pressed("A") and not Input.is_action_pressed("D") and not Input.is_action_pressed("S") and not Input.is_action_pressed("W"): 
		moving = false
		acceleration = 0
		if facing == "right":
			animationPlayer.play("Idle_Right")
		if facing == "left":
			animationPlayer.play("Idle_Left")
		if facing == "up":
			animationPlayer.play("Idle_Up")
		if facing == "down":
			animationPlayer.play("Idle_Down")
		
		
		
		
	if moving and acceleration < max_acceleration:
		acceleration += .1
	
	
	
	velocity = move_and_slide(velocity.normalized() * speed * acceleration)
