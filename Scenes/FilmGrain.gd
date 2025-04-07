extends Sprite2D

func _ready() -> void:
	visible = GameManager.film_grain
	GameManager.film_grain_changed.connect(func(on): visible = on)

func _process(delta: float) -> void:
	region_rect.position.x = randf() * 1280
	region_rect.position.y = randf() * 720
