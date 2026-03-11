extends Node
@onready var points_label: Label = %PointsLabel

var points = 0

func add_point():
	points += 1
	print(points)
	points_label.text = "Score: " + str(points)

func reset_point():
	points = 0
	print(points)
	points_label.text = "Score: " + str(points)
	
func high_points(high_score):
	points = high_score
