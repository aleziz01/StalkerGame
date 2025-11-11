extends CharacterBody2D


const SPEED = 10000.0
const FRICTION = 250000.0

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
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") && shootable:
		shootable=false
		shoot(weaponName)

var proj=preload("res://scenes/projectile.tscn")
@onready var parent=get_parent()

func shoot(weaponName):
	if weaponName=="makarov":
		shootTimer.wait_time=0.2
		shootTimer.start()
		var projInstance=proj.instantiate()
		projInstance.direction=Vector2(cos(rotation),sin(rotation))
		projInstance.speed=300
		projInstance.initpos=global_position
		projInstance.rot=rotation
		parent.get_child(1).add_child(projInstance)


func _on_shoot_timer_timeout() -> void:
	shootable=true
