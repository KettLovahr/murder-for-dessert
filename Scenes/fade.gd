extends ColorRect

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
