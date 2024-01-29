extends "res://mob.gd"

@onready var UI = %UI

func _on_hitbox_area_entered(area):
	if area.name == "Bullet":
		if area.hexColor == "#0000ff":
			queue_free()
			if UI:
				UI.update_score()
	pass # Replace with function body.
