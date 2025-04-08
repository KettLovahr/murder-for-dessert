extends Node2D


func _ready() -> void:
	$EasyMode.button_pressed = GameManager.easy_mode


func _on_start_button_pressed() -> void:
	$Start.stop()
	$Loop.stop()
	$End.play()
	visible = false
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_easy_mode_toggled(toggled_on: bool) -> void:
	GameManager.easy_mode = toggled_on
