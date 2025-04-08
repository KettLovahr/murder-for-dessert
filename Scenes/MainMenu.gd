extends Node2D


func _ready() -> void:
	$CheckBox.button_pressed = GameManager.film_grain
	$EasyMode.button_pressed = GameManager.easy_mode


func _on_start_button_pressed() -> void:
	$Start.stop()
	$Loop.stop()
	$End.play()
	visible = false
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/IntroScene.tscn")


func _on_check_box_toggled(toggled_on: bool) -> void:
	GameManager.film_grain = toggled_on


func _on_instructions_pressed() -> void:
	$CloseInstructions.show()


func _on_close_instructions_pressed() -> void:
	$CloseInstructions.hide()


func _on_easy_mode_toggled(toggled_on: bool) -> void:
	GameManager.easy_mode = toggled_on
