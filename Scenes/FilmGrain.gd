extends Sprite2D

func _process(delta: float) -> void:
	region_rect.position.x = randf() * 1280
	region_rect.position.y = randf() * 720
