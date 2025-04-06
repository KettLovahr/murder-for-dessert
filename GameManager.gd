extends Node

var pins: Array[DialogueLine]
var lives: int = 15

signal line_added(line: DialogueLine)

@onready var trees: Dictionary[String, DialogueTree] = {
	"ZAMORA": preload("res://Assets/DialogueScenes/Trees/zamora_tree.tres")
}

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
