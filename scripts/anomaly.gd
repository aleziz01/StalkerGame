extends Node2D


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("entity") && !body.dead:
		spin(body)

@onready var attack_particles: GPUParticles2D = $AttackParticles

var exploding=false
func spin(body):
	var radius=121
	var center=Vector2(0,0)
	var accel=0
	var rotationdeg=body.rotation_degrees
	attack_particles.emitting=true
	if body.name=="Character":
		body.get_child(4).enabled=false
		$Camera2D.enabled=true
	while true:
		var delta=get_process_delta_time()
		body.global_position=global_position+Vector2(radius*cos(rotationdeg),radius*sin(rotationdeg))
		body.rotation_degrees+=900*delta
		rotationdeg+=delta*(20+accel)
		radius-=delta*20
		accel+=delta*5
		radius=clamp(radius,0,121)
		if radius<5:
			body.rotation_degrees=rotationdeg
			explode(body)
			await get_tree().create_timer(0.5).timeout
			exploding=false
			break
		await get_tree().create_timer(delta).timeout

var hurtParticles=preload("res://scenes/hurt_particles.tscn")
@onready var explosion_particle: GPUParticles2D = $explosionParticle

func explode(body):
	exploding=true
	body.updateHP(-2000)
	body.visible=false
	explosion_particle.emitting=true
	while(exploding):
		await get_tree().create_timer(0.02).timeout
		var hurtParticleInstance=hurtParticles.instantiate()
		add_child(hurtParticleInstance)
		hurtParticleInstance.emitting=true
		
