extends Area2D
@onready var spel_manager: Node = %Spelmanager

var speed: float = 800
var start_y: float

func _ready() -> void:
	start_y = position.y
	respawn()

func _process(delta: float) -> void:
	position.x -= speed * delta

	if position.x < 0:
		respawn()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		spel_manager.add_point()
		respawn()

func respawn() -> void:
	position.x = get_viewport_rect().size.x + 6000
	position.y = start_y
