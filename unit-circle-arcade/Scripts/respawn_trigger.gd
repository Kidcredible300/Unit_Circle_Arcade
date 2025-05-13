extends Area2D

@export var respawn_pos : Vector2

func _on_body_entered(body: CharacterBody2D) -> void:
	await get_tree().create_timer(.5).timeout
	body.position = respawn_pos
	body.velocity = Vector2(0, -300)
