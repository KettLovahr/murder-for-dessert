extends Node2D

@onready var main_scene: PackedScene = preload("res://Scenes/MainScene.tscn")

func _ready() -> void:
	$DialogueUi.init_scene(
		load("res://Assets/DialogueScenes/new_test_dialogue.tres"),
		null
	)


func _on_dialogue_ui_scene_completed() -> void:
	get_tree().change_scene_to_packed(main_scene)
