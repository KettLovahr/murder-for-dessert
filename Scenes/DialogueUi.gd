extends Control

@export var dialogue: DialogueScene
@onready var dialogue_label: RichTextLabel = $DialogueBox/DialogueLabel

#@onready var speaker_color: ColorRect = $DialogueBox/SpeakerColor
@onready var speaker_label: Label = $DialogueBox/SpeakerLabel
@onready var culprit_label: Label = $CulpritLabel

var current_line: int = 0

func _ready():
	culprit_label.text = GameManager.current_culprit
	_update_line()
	
func _process(_delta):
	var vis_char = dialogue_label.visible_characters
	if vis_char < len(dialogue_label.text) and vis_char != -1:
		dialogue_label.visible_characters += 1

func _update_line():
	var dia = dialogue.lines[current_line]
	dialogue_label.text = dia.line
	dialogue_label.visible_characters = 0
#	speaker_color.color = dia.speaker.color
	speaker_label.text = dia.speaker.name
	#speaker_label.add_theme_color_override("font_color",
		#Color.WHITE if dia.speaker.color.get_luminance() < 0.5
					#else Color.BLACK)
	_update_buttons()
	
func _update_buttons():
	$DialogueBox/NavButtonContainer/Previous.disabled = current_line == 0
	$DialogueBox/NavButtonContainer/Next.disabled = current_line == len(dialogue.lines) - 1

func _on_previous_pressed() -> void:
	if current_line > 0:
		current_line -= 1
		_update_line()

func _on_next_pressed() -> void:
	if dialogue_label.visible_ratio < 1.0 and dialogue_label.visible_characters != -1:
		dialogue_label.visible_characters = -1
	elif current_line < len(dialogue.lines) - 1:
		current_line += 1
		_update_line()

func _on_pin_action_button_pressed() -> void:
	var line = dialogue.lines[current_line]
	GameManager.add_pin(line)
