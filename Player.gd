extends KinematicBody2D

var acceleration = 0
var max_acceleration = 2
var speed = 25
var velocity = Vector2.ZERO
var moving = false
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("W"):
		velocity.y -= 1
		moving = true
		
	if Input.is_action_pressed("A"):
		velocity.x -= 1
		moving = true
		
	if Input.is_action_pressed("D"):
		velocity.x += 1
		moving = true
		
	if Input.is_action_pressed("S"):
		velocity.y += 1
		moving = true
		
	if not Input.is_action_pressed("A") and not Input.is_action_pressed("D") and not Input.is_action_pressed("S") and not Input.is_action_pressed("W"): 
		moving = false
		acceleration = 0
	
	
	if moving:
		animationTree.set("parameters/Idle/blend_position", velocity)
		animationTree.set("parameters/Run/blend_position", velocity)
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
	
	if moving and acceleration < max_acceleration:
		acceleration += .1
	
	
	
	velocity = move_and_slide(velocity.normalized() * speed * acceleration)
