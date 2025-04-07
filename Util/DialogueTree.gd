extends Resource
class_name DialogueTree

@export var culprit: String

# Unlocking a scene that is follow by a "null" should trigger the "brick wall" 
# on the interface

@export_category("Level 1")
@export var level_1_scene: DialogueScene
@export var level_1_unlocked: bool = true
@export var level_1_pin: DialogueLine

@export_category("Level 2")
@export var level_2_scene: DialogueScene
@export var level_2_unlocked: bool
@export var level_2_pin: DialogueLine

@export_category("Level 3")
@export var level_3_scene: DialogueScene
@export var level_3_unlocked: bool
@export var level_3_pin: DialogueLine

@export_category("Level 4")
@export var level_4_scene: DialogueScene
@export var level_4_unlocked: bool
@export var level_4_pin: DialogueLine

@export_category("Level 5")
@export var level_5_scene: DialogueScene
@export var level_5_unlocked: bool
@export var level_5_pin: DialogueLine
