extends CharacterBody2D

var speed=25
var direction=Vector2.ZERO

func _physics_process(delta: float) -> void:
	if target:
		direction=(target.global_position-global_position).normalized()
	global_position+=direction*speed*delta
	move_and_slide()
@onready var timer: Timer = $Timer

var target=null
func _on_detection_range_body_entered(body: Node2D) -> void:
	target=body
	speed=200
	direction=(body.global_position-global_position).normalized()
	timer.stop()

func _on_timer_timeout() -> void:
	direction=Vector2(randf_range(-1,1),randf_range(-1,1))
	await get_tree().create_timer(2.0).timeout
	direction=Vector2.ZERO
