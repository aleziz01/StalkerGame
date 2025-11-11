extends Area2D

var direction=Vector2.ZERO
var speed = 100
func _process(delta: float) -> void:
	position+=direction*speed*delta
