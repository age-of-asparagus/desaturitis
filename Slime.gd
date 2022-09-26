extends KinematicBody2D

var player = null
var speed = 40


func _physics_process(delta):
	
	print(player)
	
	if player != null and $Player_detector.get_overlapping_bodies():
		var direction = player.global_position - global_position
		move_and_slide(direction.normalized() * speed)






func _on_Player_detector_body_entered(body):
	player = body


