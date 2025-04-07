extends Control
class_name DialogueUi

@export var dialogue: DialogueScene
@export var tree: DialogueTree

@export var culprit: String

@onready var dialogue_label: RichTextLabel = $DialogueBox/DialogueLabel

#@onready var speaker_color: ColorRect = $DialogueBox/SpeakerColor
@onready var speaker_label: Label = $DialogueBox/SpeakerLabel
@onready var culprit_label: Label = $CulpritLabel

@onready var char_sprite: CharacterSprite = $CharacterSprite

@onready var dialogue_box: Texture2D = preload("res://Assets/Textures/Conversation/dialogue_box.png")
@onready var dialogue_box_noname: Texture2D = preload("res://Assets/Textures/Conversation/dialogue_box_noname.png")

var done_speaking: bool = false

signal scene_completed()
signal exit_request()
signal cut_all_music()

var current_line: int = 0

func _ready():
	reset()

func reset():
	if dialogue:
		current_line = 0
		_update_line()
		if tree:
			$CulpritLabel.text = tree.culprit
			_update_tree_buttons()
			_show_tree_ui(true)
		else:
			_show_tree_ui(false)
		char_sprite.switch_to_any_sprite(null)

func init_scene(scene: DialogueScene, new_tree: DialogueTree):
	dialogue = scene
	tree = new_tree
	reset()
	$DialogueUiAnim.play("fade_in")

func fade_out():
	$DialogueUiAnim.play("fade_out")

func _show_tree_ui(opt: bool):
	for child in get_children():
		if child.is_in_group("InvestigationOnly"):
			child.visible = opt

func _process(_delta):
	var vis_char = dialogue_label.visible_characters
	if dialogue_label.visible_ratio != 1 and vis_char != -1:
		dialogue_label.visible_characters += 1
	else:
		if not done_speaking:
			char_sprite.stop_speaking()
			done_speaking = true

func navigation_enabled(opt: bool) -> void:
	if not opt:
		for child in get_children():
			if child.is_in_group("InvestigationOnly"):
				if child is TextureButton:
					child.disabled = true
					if child.is_in_group("ConversationButton"):
						child.texture_disabled = load("res://Assets/Textures/Conversation/conversation_unknown.png")
	else:
		$BackButton.disabled = false
		_update_tree_buttons()

func _update_line():
	done_speaking = false
	var dia = dialogue.lines[current_line]
	dialogue_label.text = dia.line
	dialogue_label.visible_characters = 0
	if dia.speaker:
		speaker_label.text = dia.speaker.name
		$DialogueBox/DialogueLabel.modulate = Color.WHITE
		if (dia.image_override):
			char_sprite.switch_to_any_sprite(dia.image_override)
		elif (dia.speaker.speaking_sprite):
			char_sprite.switch_to_charsprite(dia.speaker, true)
		$DialogueBox/PinActionButton.visible = dia.speaker.pinnable and (tree != null)
		$DialogueBox.texture = dialogue_box
	else:
		speaker_label.text = ""
		$DialogueBox/DialogueLabel.modulate = Color.from_rgba8(255, 255, 255, 128)
		$DialogueBox/PinActionButton.visible = false
		$DialogueBox.texture = dialogue_box_noname

	_update_buttons()

func _update_buttons():
	$DialogueBox/NavButtonContainer/Previous.disabled = current_line == 0
	# $DialogueBox/NavButtonContainer/Next.disabled = current_line == len(dialogue.lines) - 1

func _update_tree_buttons():
	if tree:
		var brick_wall = false
		var previous_unlocked = true
		for i in range(1, 6):
			var button: ConversationButton = get_node("ConversationButton%d" % [i])
			button.disabled = true

			var scene: DialogueScene = tree.get("level_%s_scene" % [i])
			var unlocked: bool = tree.get("level_%s_unlocked" % [i])

			if unlocked:
				if scene:
					button.associated_scene = scene
					button.disabled = false
					previous_unlocked = true
			else:
				if previous_unlocked:
					if scene:
						button.texture_disabled = load("res://Assets/Textures/Conversation/conversation_next.png")
						previous_unlocked = false
					else:
						brick_wall = true
				else:
					button.texture_disabled = load("res://Assets/Textures/Conversation/conversation_unknown.png")
			if brick_wall:
				button.texture_disabled = load("res://Assets/Textures/Conversation/conversation_brick_wall.png")

func _on_previous_pressed() -> void:
	if current_line > 0:
		current_line -= 1
		_update_line()
		$NextPrev.play()
		dialogue_label.visible_characters = -1

func _on_next_pressed() -> void:
	if dialogue_label.visible_ratio < 1.0 and dialogue_label.visible_characters != -1:
		dialogue_label.visible_characters = -1
	elif current_line < len(dialogue.lines) - 1:
		current_line += 1
		_update_line()
		$NextPrev.play()
	else:
		if dialogue.resource_name == "PennyLevel5":
			GameManager.win.emit()
			fade_out()
			return
		scene_completed.emit()

func _on_pin_action_button_pressed() -> void:
	var line = dialogue.lines[current_line]
	GameManager.add_pin(line)

func _handle_change_scene(scene: DialogueScene) -> void:
	dialogue = scene
	reset()
	if dialogue.resource_name == "PennyLevel5":
		cut_all_music.emit()

func get_current_displayed_line() -> DialogueLine:
	return dialogue.lines[current_line]

func _on_back_button_pressed() -> void:
	exit_request.emit()
