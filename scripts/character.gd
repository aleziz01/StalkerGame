extends CharacterBody2D


const SPEED = 10000.0

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	var directionx := Input.get_axis("left", "right")
	var directiony := Input.get_axis("up","down")
	if directionx:
		velocity.x+=directionx*SPEED*delta
		velocity.x=clamp(velocity.x,-300,300)
	else:
		velocity.x=0
	if directiony:
		velocity.y+=directiony*SPEED*delta
		velocity.y=clamp(velocity.y,-300,300)
	else:
		velocity.y=0
	move_and_slide()

@onready var shootTimer: Timer = $shootTimer
var shootable=true
var weaponName="makarov"
func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") && shootable:
		shootable=false
		shoot(weaponName)

var proj=preload("res://scenes/projectile.tscn")
@onready var parent=get_parent()
@onready var weapon_position: Node2D = $weaponPosition

func shoot(weaponName):
	if weaponName=="makarov":
		shootTimer.wait_time=0.2
		shootTimer.start()
		var projInstance=proj.instantiate()
		projInstance.direction=Vector2(cos(rotation),sin(rotation))
		projInstance.speed=1200
		projInstance.initpos=weapon_position.global_position
		projInstance.rot=rotation
		projInstance.damage=20
		parent.get_child(1).add_child(projInstance)


func _on_shoot_timer_timeout() -> void:
	shootable=true

var hp=100
func updateHP(hpAmount):
	hp+=hpAmount
	if hpAmount<0:
		damageAnim()
	if hp<=0:
		die()

func damageAnim(): #TODO
	pass

func die(): #TODO
	pass
