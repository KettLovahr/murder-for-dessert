extends Node2D

@onready var dialogue_ui: DialogueUi = $UILayer/DialogueUi

func _ready() -> void:
	#init_scene(
		#load("res://Assets/DialogueScenes/many_characters_test.tres"),
		#null
	#)
	pass

func _on_dialogue_ui_scene_completed() -> void:
	# dialogue_ui.fade_out()
	var tree: DialogueTree = dialogue_ui.tree
	dialogue_ui.navigation_enabled(true)
	if dialogue_ui.dialogue != GameManager.default_scenes[tree.culprit.to_upper()]:
		dialogue_ui._handle_change_scene(
			GameManager.default_scenes[tree.culprit.to_upper()],
		)

func _on_hub_scene_requested(which: String) -> void:
	if which in GameManager.trees:
		var tree: DialogueTree = GameManager.trees[which]
		dialogue_ui.init_scene(
			GameManager.default_scenes[which],
			tree
		)

func _on_inventory_pin_used(pin: DialogueLine) -> void:
	var shown_line: DialogueLine = dialogue_ui.get_current_displayed_line()
	var tree: DialogueTree = dialogue_ui.tree
	if GameManager.check_pin(tree.culprit.to_upper(), pin):
		dialogue_ui._handle_change_scene(GameManager.unlock_next(tree.culprit.to_upper()))
		dialogue_ui.navigation_enabled(false)
	else:
		var new_scene = GameManager.fail_scenes[tree.culprit.to_upper()]
		dialogue_ui._handle_change_scene(new_scene)
		GameManager.lives -= 1


func _on_dialogue_ui_exit_request() -> void:
	dialogue_ui.fade_out()
