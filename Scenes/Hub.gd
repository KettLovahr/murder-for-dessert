extends Node2D

signal scene_requested(which: String)

func _on_bethany_button_pressed() -> void:
	scene_requested.emit("BETHANY")

func _on_billy_button_pressed() -> void:
	scene_requested.emit("BILLY")

func _on_penny_button_pressed() -> void:
	scene_requested.emit("PENNY")

func _on_richard_button_pressed() -> void:
	scene_requested.emit("RICHARD")

func _on_zamora_button_pressed() -> void:
	scene_requested.emit("ZAMORA")
