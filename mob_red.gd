extends "res://mob.gd"


func _on_hitbox_area_entered(area):
	if area.name == "Bullet":
		if area.hexColor == "#ff0000":
			queue_free()
	pass # Replace with function body.
