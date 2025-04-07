extends Node2D

@onready var dialogue_ui: DialogueUi = $UILayer/DialogueUi
@onready var inventory_ui = $UILayer/Inventory

func _ready() -> void:
	#init_scene(
		#load("res://Assets/DialogueScenes/many_characters_test.tres"),
		#null
	#)
	GameManager.reset()
	GameManager.lose.connect(_on_lose)
	GameManager.win.connect(_on_win)

func _on_dialogue_ui_scene_completed() -> void:
	# dialogue_ui.fade_out()
	var tree: DialogueTree = dialogue_ui.tree
	dialogue_ui.navigation_enabled(true)
	inventory_ui.pins_enabled(true)
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
		inventory_ui.pins_enabled(false)
	else:
		var new_scene = GameManager.fail_scenes[tree.culprit.to_upper()]
		dialogue_ui._handle_change_scene(new_scene)
		GameManager.lives -= 1
		$Fail.play()


func _on_dialogue_ui_exit_request() -> void:
	dialogue_ui.fade_out()


func _on_lose() -> void:
	$AudioStreamPlayer/AudioFader.play("fade_out")
	$UILayer/Fade.fade_out()
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")


func _on_win() -> void:
	$UILayer/Fade.fade_out()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/OutroScene.tscn")


func _on_dialogue_ui_cut_all_music() -> void:
	inventory_ui.pins_enabled(false)
	$AudioStreamPlayer/AudioFader.play("fade_out")
