extends Node2D

func _ready() -> void:
	#init_scene(
		#load("res://Assets/DialogueScenes/many_characters_test.tres"),
		#null
	#)
	pass

func _on_dialogue_ui_scene_completed() -> void:
	$UILayer/DialogueUi.fade_out()

func _on_hub_scene_requested(which: String) -> void:
	if which in GameManager.trees:
		var tree: DialogueTree = GameManager.trees[which]
		$UILayer/DialogueUi.init_scene(
			tree.level_1_scene,
			tree
		)
