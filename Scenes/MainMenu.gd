extends Node2D

@onready var intro_scene: PackedScene = preload("res://Scenes/IntroScene.tscn")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(intro_scene)
