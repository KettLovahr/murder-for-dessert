extends Node

var film_grain := true:
	set(v):
		film_grain_changed.emit(v)
		film_grain = v

var pins: Array[DialogueLine]
var lives: int = 10:
	set(v):
		life_count_changed.emit(v)
		if v == 0:
			lose.emit()
		lives = v

signal line_added(line: DialogueLine)
signal life_count_changed(amount: int)
signal film_grain_changed(on: bool)
signal win()
signal lose()

@onready var trees: Dictionary[String, DialogueTree] = {
	"BETHANY": preload("res://Assets/DialogueScenes/Trees/bethany_tree.tres"),
	"BILLY": preload("res://Assets/DialogueScenes/Trees/billy_tree.tres"),
	"PENNY": preload("res://Assets/DialogueScenes/Trees/penny_tree.tres"),
	"RICHARD": preload("res://Assets/DialogueScenes/Trees/richard_tree.tres"),
	"ZAMORA": preload("res://Assets/DialogueScenes/Trees/zamora_tree.tres"),
}

@onready var default_scenes: Dictionary[String, DialogueScene] = {
	"BETHANY": preload("res://Assets/DialogueScenes/DefaultDialogue/BethanyDefault.tres"),
	"BILLY": preload("res://Assets/DialogueScenes/DefaultDialogue/BillyDefault.tres"),
	"PENNY": preload("res://Assets/DialogueScenes/DefaultDialogue/PennyDefault.tres"),
	"RICHARD": preload("res://Assets/DialogueScenes/DefaultDialogue/RichardDefault.tres"),
	"ZAMORA": preload("res://Assets/DialogueScenes/DefaultDialogue/ZamoraDefault.tres"),
}

@onready var fail_scenes: Dictionary[String, DialogueScene] = {
	"BETHANY": preload("res://Assets/DialogueScenes/FailDialogue/BethanyFail.tres"),
	"BILLY": preload("res://Assets/DialogueScenes/FailDialogue/BillyFail.tres"),
	"PENNY": preload("res://Assets/DialogueScenes/FailDialogue/PennyFail.tres"),
	"RICHARD": preload("res://Assets/DialogueScenes/FailDialogue/RichardFail.tres"),
	"ZAMORA": preload("res://Assets/DialogueScenes/FailDialogue/ZamoraFail.tres"),
}

@onready var default_trees: Dictionary[String, DialogueTree]


func _ready() -> void:
	for item in trees:
		default_trees[item] = trees[item].duplicate()
	print(default_trees)
	pass

func add_pin(line: DialogueLine) -> void:
	if line not in pins and len(pins) < 9:
		pins.append(line)
		line_added.emit(line)

func delete_pin(line: DialogueLine) -> void:
	for i in len(pins):
		if pins[i] == line:
			pins.remove_at(i)
			break

func reset():
	pins = []
	trees.clear()
	for key in default_trees:
		trees[key] = default_trees[key].duplicate()
	lives = 10

func unlock_next(tree: String) -> DialogueScene:
	if tree in trees:
		for i in range(2, 6):
			if not trees[tree].get("level_%d_unlocked" % [i]):
				trees[tree].set("level_%d_unlocked" % [i], true)
				return trees[tree].get("level_%d_scene" % [i])
	return null # This should be unreachable.

func check_pin(tree: String, pin: DialogueLine) -> bool:
	if tree in trees:
		for i in range(5, 0, -1):
			if trees[tree].get("level_%d_unlocked" % [i]):
				return trees[tree].get("level_%d_pin" % [i]) == pin
	return false
