extends TextureButton
class_name PinButton

var associated_line: DialogueLine

signal delete_line(line: DialogueLine)
signal use_line(line: DialogueLine)

signal requested_visibility(who: PinButton)

func _ready() -> void:
	$Tooltip/LineLabel.bbcode_enabled = true
	$Tooltip/LineLabel.text = associated_line.line
	texture_normal = associated_line.speaker.pin_sprite

func _on_use_button_pressed() -> void:
	use_line.emit(associated_line)

func _on_delete_button_pressed() -> void:
	delete_line.emit(associated_line)

func _on_pressed() -> void:
	if not $Tooltip.visible:
		requested_visibility.emit(self)
	else:
		$Tooltip.visible = false
