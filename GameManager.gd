extends Node

var pins: Array[DialogueLine]
var lives: int = 15

signal line_added(line: DialogueLine)

@onready var trees: Dictionary[String, DialogueTree] = {
	"BETHANY": preload("res://Assets/DialogueScenes/Trees/bethany_tree.tres"),
	"BILLY": preload("res://Assets/DialogueScenes/Trees/billy_tree.tres"),
	"PENNY": preload("res://Assets/DialogueScenes/Trees/penny_tree.tres"),
	"RICHARD": preload("res://Assets/DialogueScenes/Trees/richard_tree.tres"),
	"ZAMORA": preload("res://Assets/DialogueScenes/Trees/zamora_tree.tres"),
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
