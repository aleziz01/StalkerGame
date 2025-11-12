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

@onready var particlePosition: Node2D = $ParticlePosition

var endParticles=preload("res://scenes/BulletParticlesWall.tscn")
func _on_body_entered(body: Node2D) -> void:
	var endParticleInstance=endParticles.instantiate()
	get_parent().add_child(endParticleInstance)
	endParticleInstance.global_position=particlePosition.global_position
	endParticleInstance.rotation=rotation
	queue_free()
