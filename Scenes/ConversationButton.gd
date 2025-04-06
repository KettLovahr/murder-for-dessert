extends TextureButton
class_name ConversationButton

@export var associated_scene: DialogueScene

signal change_scene(scene: DialogueScene)

func _on_pressed() -> void:
	change_scene.emit(associated_scene)
