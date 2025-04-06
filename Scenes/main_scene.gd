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

func _on_inventory_pin_used(pin: DialogueLine) -> void:
	var shown_line: DialogueLine = $UILayer/DialogueUi.get_current_displayed_line()
	var tree: DialogueTree = $UILayer/DialogueUi.tree
	if shown_line.refutation == pin:
		$UILayer/DialogueUi._handle_change_scene(GameManager.unlock_next(tree.culprit.to_upper()))
	else:
		var new_scene = GameManager.fail_scenes[tree.culprit.to_upper()]
		$UILayer/DialogueUi._handle_change_scene(new_scene)
		GameManager.lives -= 1
