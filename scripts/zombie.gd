extends CharacterBody2D

var speed=25
var hp=100
var direction=Vector2.ZERO
var attackCooldown=false
var target=null
var wName=null
var weapons=["makarov"]
var dead=false

func _ready() -> void:
	wName=weapons[randi_range(0,weapons.size()-1)]

func _physics_process(delta: float) -> void:
	if target && (target.global_position-global_position).length()>30:
		direction=(target.global_position-global_position).normalized()
		if !attackCooldown:
			attack(wName)
			#play the lunging animation
	elif target && (target.global_position-global_position).length()<30:
		direction=Vector2.ZERO
		#play the attacking animation here
	look_at(global_position+direction)
	global_position+=direction*speed*delta
	move_and_slide()

@onready var timer: Timer = $Timer
@onready var parent=get_parent()
@onready var weapon_position: Node2D = $weaponPosition
var proj=preload("res://scenes/projectile.tscn")

func attack(weaponName):
	var projectileCount=randi_range(2,10)
	if weaponName=="makarov":
		attackCooldown=true
		for i in projectileCount:
			await get_tree().create_timer(0.2).timeout
			if dead:
				break
			var projInstance=proj.instantiate()
			var projRot=deg_to_rad(rotation_degrees+randf_range(-20,20))
			projInstance.direction=Vector2(cos(projRot),sin(projRot))
			projInstance.speed=1200
			projInstance.initpos=weapon_position.global_position
			projInstance.rot=projRot
			projInstance.damage=20
			projInstance.set_collision_mask_value(8,true)
			projInstance.set_collision_mask_value(7,false)
			parent.get_child(1).add_child(projInstance)
		await get_tree().create_timer(3).timeout
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
	if !target:
		$DetectionRange.scale=Vector2(3,3)
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
	dead=true
	for i in get_children():
		if i!=get_child(0):
			i.queue_free()
	target=null
	direction=Vector2.ZERO
	speed=0
	z_index=-1
