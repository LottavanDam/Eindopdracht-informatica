extends Area2D
@onready var spel_manager: Node = %Spelmanager



func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		queue_free()
		spel_manager.add_point()
