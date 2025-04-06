extends Node2D

func _ready() -> void:
	init_scene(
		load("res://Assets/DialogueScenes/new_test_dialogue.tres"),
		null
	)

func _on_dialogue_ui_scene_completed() -> void:
	$UILayer/DialogueUiAnim.play("fade_out")

func init_scene(scene: DialogueScene, tree: DialogueTree):
	$UILayer/DialogueUi.dialogue = scene
	$UILayer/DialogueUi.tree = tree
	$UILayer/DialogueUi.reset()
	$UILayer/DialogueUiAnim.play("fade_in")
