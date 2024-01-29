extends Node


# Called when the node enters the scene tree for the first time.
func play_effect(clip):
	var n = $Effect_player.get_child_count()
	for i in range(n):
		var child = $Effect_player.get_child(i)
		if !child.playing:
			child.stream = clip
			child.play()
			return
