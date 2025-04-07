extends Sprite2D

var pin_button: PackedScene = preload("res://Scenes/PinButton.tscn")

signal pin_used(line: DialogueLine)
var can_use_pins := true

func _ready() -> void:
	GameManager.line_added.connect(_on_line_added)
	GameManager.life_count_changed.connect(_on_life_count_changed)

func _update_buttons() -> void:
	for child in $InventoryContainer.get_children():
		child.queue_free()
	for line in GameManager.pins:
		var new_button: PinButton = pin_button.instantiate()
		new_button.associated_line = line
		new_button.requested_visibility.connect(_handle_visibility)
		new_button.delete_line.connect(_handle_delete)
		new_button.use_line.connect(_handle_use)
		new_button.disabled = not can_use_pins
		$InventoryContainer.add_child(new_button)

func _on_line_added(_line: DialogueLine) -> void:
	_update_buttons()

func _handle_visibility(who: PinButton) -> void:
	for child in $InventoryContainer.get_children():
		if child is PinButton:
			child.get_node("Tooltip").visible = false
	who.get_node("Tooltip").visible = true

func _handle_delete(line: DialogueLine) -> void:
	$Unpin.play()
	GameManager.delete_pin(line)
	_update_buttons()

func _handle_use(line: DialogueLine):
	pin_used.emit(line)

func _on_life_count_changed(lives: int):
	$LivesLabel.text = "%d" % [lives]

func pins_enabled(opt: bool):
	for child in $InventoryContainer.get_children():
		if child is PinButton:
			child.get_node("Tooltip").visible = false
			child.disabled = not opt
			can_use_pins = opt
