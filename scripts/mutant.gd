extends CharacterBody2D

var speed=25
var direction=Vector2.ZERO
var attacking=false
var attackCooldown=false
func _physics_process(delta: float) -> void:
	if target && !attacking && (target.global_position-global_position).length()>30:
		direction=(target.global_position-global_position).normalized()
		if (target.global_position-global_position).length()<200 && !attackCooldown:
			attacking=true
			attack()
	elif target && (target.global_position-global_position).length()<30 && !attacking:
		direction=Vector2.ZERO
	look_at(global_position+direction)
	global_position+=direction*speed*delta
	move_and_slide()
@onready var timer: Timer = $Timer

func attack():
	speed=500
	attackCooldown=true
	await get_tree().create_timer(1).timeout
	attacking=false
	speed=250
	await get_tree().create_timer(2).timeout
	attackCooldown=false

var target=null
func _on_detection_range_body_entered(body: Node2D) -> void:
	target=body
	speed=250
	direction=(body.global_position-global_position).normalized()
	timer.stop()

func _on_timer_timeout() -> void:
	direction=Vector2(randf_range(-1,1),randf_range(-1,1))
	await get_tree().create_timer(2.0).timeout
	direction=Vector2.ZERO
