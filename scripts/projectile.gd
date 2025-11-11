extends Area2D

var direction=Vector2(1,0)
var speed = 1000
var initpos=Vector2.ZERO
var rot=0
func _ready() -> void:
	global_position=initpos
	rotation=rot

func _process(delta: float) -> void:
	position+=direction*speed*delta
	print(position)

func _on_decay_timer_timeout() -> void:
	queue_free()
