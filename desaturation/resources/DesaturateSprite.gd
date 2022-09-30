extends Sprite


func _on_Area2D_area_entered(area):
	# Only detect "healing"  / color replacement
	# so switch shader mode to replace color
	print("color back")
	$AnimationPlayer.play("Unfade")
	
