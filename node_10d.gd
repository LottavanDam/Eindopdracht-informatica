extends Node2D

var screen_size : Vector2i
var tas_scene = preload("res://Eindopdracht-informatica/tas.tscn")

var obstacle_types := [tas_scene]
var obstacles : Array = []
var last_obs

# snelheid van obstacles
var speed : float = 1300

# visuele grondhoogte
var ground_y : float = 3590


func _on_area_entered(area):
	if area.name == "tas":
		get_tree().paused = true


func new_game():
	obstacles.clear()
	get_tree().paused = false
	$GameOver.hide()
	

	for obs in obstacles:
		obs.queue_free()
	obstacles.clear()

func _ready() -> void:
	screen_size = get_window().size
	$GameOver.get_node("Button").pressed.connect(new_game)
	new_game()


func _process(delta: float) -> void:
	speed += 30 * delta
	generate_obs()

	for obs in obstacles:
		obs.position.x -= speed * delta
		
		if obs.position.x < -180:
			obstacles.erase(obs)
			obs.queue_free()


func generate_obs():
	if obstacles.is_empty():
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs = obs_type.instantiate()


		# spawn rechts buiten scherm
		var obs_x = screen_size.x + 4500
		obs.body_entered.connect(hit_obs)
		# pak sprite
		var sprite = obs.get_node_or_null("Sprite2D")
		if sprite == null:
			return

		# bereken Y positie op grond
		var obs_y = ground_y - (sprite.texture.get_height() / 2)

		obs.position = Vector2(obs_x, obs_y)
		add_child(obs)

		obstacles.append(obs)
		last_obs = obs
func hit_obs(body):
	if body.name == "CharacterBody2D":
		game_over()


func game_over():
	get_tree().paused = true
	$GameOver.show()
	
