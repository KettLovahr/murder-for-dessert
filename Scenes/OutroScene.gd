extends Node2D


func _ready() -> void:
	await get_tree().create_timer(3).timeout
	$DialogueUi.init_scene(
		load("res://Assets/DialogueScenes/outro_dialogue.tres"),
		null
	)


func _on_dialogue_ui_scene_completed() -> void:
	$DialogueUi.fade_out()
	$AudioStreamPlayer/AudioFader.play("fade_out")
	$Fade.fade_out()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/Fin.tscn")
