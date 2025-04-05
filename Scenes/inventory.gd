extends Sprite2D

var pin_button: PackedScene = preload("res://Scenes/PinButton.tscn")

func _ready() -> void:
	GameManager.line_added.connect(_on_line_added)
	

func _update_buttons() -> void:
	for child in $InventoryContainer.get_children():
		child.queue_free()
	for line in GameManager.pins:
		var new_button: PinButton = pin_button.instantiate()
		new_button.associated_line = line
		new_button.requested_visibility.connect(_handle_visibility)
		new_button.delete_line.connect(_handle_delete)
		$InventoryContainer.add_child(new_button)

func _on_line_added(_line: DialogueLine) -> void:
	_update_buttons()

func _handle_visibility(who: PinButton) -> void:
	for child in $InventoryContainer.get_children():
		if child is PinButton:
			child.get_node("Tooltip").visible = false
	who.get_node("Tooltip").visible = true

func _handle_delete(line: DialogueLine) -> void:
	GameManager.delete_pin(line)
	_update_buttons()
