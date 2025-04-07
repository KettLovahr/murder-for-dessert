extends Node2D


func _on_start_button_pressed() -> void:
	$Loop.stop()
	$End.play()
	visible = false
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
