extends Sprite2D
class_name CharacterSprite

var speaker: DialogueSpeaker

func switch_to_charsprite(new_speaker: DialogueSpeaker, speaking_sprite: bool):
	if new_speaker:
		texture = new_speaker.speaking_sprite if speaking_sprite else new_speaker.sprite
		if new_speaker != speaker:
			speaker = new_speaker
			$SpriteAnimPlayer.play("switch_anim")
		if speaking_sprite:
			create_tween().tween_property(self, "position", Vector2(0, 0), 0.1)
		else:
			create_tween().tween_property(self, "position", Vector2(0, 16), 0.1)

func switch_to_any_sprite(sprite: Texture2D):
	if sprite:
		texture = sprite
		speaker = null

func stop_speaking():
	switch_to_charsprite(speaker, false)
