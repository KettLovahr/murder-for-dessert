extends ColorRect

@export var auto_fade_in := true

func _ready() -> void:
	if not auto_fade_in:
		$AnimationPlayer.stop()
		visible = false

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
