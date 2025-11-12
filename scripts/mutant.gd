extends CharacterBody2D

var speed=25
var hp=100
var direction=Vector2.ZERO
var attacking=false
var attackCooldown=false
var target=null

func _physics_process(delta: float) -> void:
	if target && !attacking && (target.global_position-global_position).length()>30:
		direction=(target.global_position-global_position).normalized()
		if (target.global_position-global_position).length()<200 && !attackCooldown:
			attacking=true
			attack()
			#play the lunging animation
		else:
			pass
			#play the following animation (running animation for mutant) 
	elif target && (target.global_position-global_position).length()<30 && !attacking:
		direction=Vector2.ZERO
		#play the attacking animation here
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


func _on_detection_range_body_entered(body: Node2D) -> void:
	target=body
	speed=250
	direction=(body.global_position-global_position).normalized()
	timer.stop()

func _on_timer_timeout() -> void:
	direction=Vector2(randf_range(-1,1),randf_range(-1,1))
	await get_tree().create_timer(2.0).timeout
	direction=Vector2.ZERO

func updateHP(hpAmount):
	hp+=hpAmount
	if hpAmount<0:
		damageAnim()
	if hp<=0:
		die()

func damageAnim():
	modulate=Color(1.137, 0.317, 0.0, 1.0) #change this color to accomodate to the sprites
	await get_tree().create_timer(0.1).timeout
	modulate=Color(1.0, 1.0, 1.0, 1.0)

func die():
	#play death animation
	for i in get_children():
		if i!=get_child(0):
			i.queue_free()
	target=null
	direction=Vector2.ZERO
	speed=0
	z_index=-1
