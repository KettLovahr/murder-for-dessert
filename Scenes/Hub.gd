extends Node2D

signal scene_requested(which: String)

func _process(delta: float) -> void:
	$FilmGrain.region_rect.position.x = randf() * 1280
	$FilmGrain.region_rect.position.y = randf() * 720

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
