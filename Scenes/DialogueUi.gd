extends Control

@export var dialogue: DialogueScene
@export var culprit: String

@onready var dialogue_label: RichTextLabel = $DialogueBox/DialogueLabel

#@onready var speaker_color: ColorRect = $DialogueBox/SpeakerColor
@onready var speaker_label: Label = $DialogueBox/SpeakerLabel
@onready var culprit_label: Label = $CulpritLabel

signal scene_completed()

var current_line: int = 0

func _ready():
	reset()
	
func reset():
	if dialogue:
		$CulpritLabel.text = dialogue.culprit
		current_line = 0
		_update_line()
		
	
func _process(_delta):
	var vis_char = dialogue_label.visible_characters
	if vis_char < len(dialogue_label.text) and vis_char != -1:
		dialogue_label.visible_characters += 1

func _update_line():
	var dia = dialogue.lines[current_line]
	dialogue_label.text = dia.line
	dialogue_label.visible_characters = 0
	if dia.speaker:
		speaker_label.text = dia.speaker.name
		$DialogueBox/DialogueLabel.modulate = Color.WHITE
		if (dia.image_override):
			_update_speaker_sprite(dia.image_override)
		elif (dia.speaker.speaker_sprite):
			_update_speaker_sprite(dia.speaker.speaker_sprite)
		$DialogueBox/PinActionButton.visible = dia.speaker.pinnable
	else:
		speaker_label.text = ""
		$DialogueBox/DialogueLabel.modulate = Color.from_rgba8(255, 255, 255, 128)
		$DialogueBox/PinActionButton.visible = false

	_update_buttons()
	
func _update_buttons():
	$DialogueBox/NavButtonContainer/Previous.disabled = current_line == 0
	# $DialogueBox/NavButtonContainer/Next.disabled = current_line == len(dialogue.lines) - 1

func _update_speaker_sprite(to: Texture2D):
	if $CharacterSprite.texture != to:
		$CharacterSprite.texture = to
		$CharacterSprite/SpriteAnimPlayer.play("switch_anim")

func _on_previous_pressed() -> void:
	if current_line > 0:
		current_line -= 1
		_update_line()
		dialogue_label.visible_characters = -1

func _on_next_pressed() -> void:
	if dialogue_label.visible_ratio < 1.0 and dialogue_label.visible_characters != -1:
		dialogue_label.visible_characters = -1
	elif current_line < len(dialogue.lines) - 1:
		current_line += 1
		_update_line()
	else:
		scene_completed.emit()
	

func _on_pin_action_button_pressed() -> void:
	var line = dialogue.lines[current_line]
	GameManager.add_pin(line)
