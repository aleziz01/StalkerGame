extends Line2D

var queue1: Array

@onready var projectile: Area2D = $".."

func _process(delta: float) -> void:
	add_point(global_position)
