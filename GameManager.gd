extends Node

var pins: Array[DialogueLine]
var current_culprit: String = "Richard"
var lives: int = 15

signal line_added(line: DialogueLine)

func _ready() -> void:
	pass

func add_pin(line: DialogueLine) -> void:
	if line not in pins:
		pins.append(line)
		line_added.emit(line)

func delete_pin(line: DialogueLine) -> void:
	for i in len(pins):
		if pins[i] == line:
			pins.remove_at(i)
			break
