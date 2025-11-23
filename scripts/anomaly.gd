extends Node2D


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("entity") && !body.dead:
		spin(body)

@onready var attack_particles: GPUParticles2D = $AttackParticles

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
		rotationdeg+=delta*(20+accel)
		radius-=delta*20
		accel+=delta*5
		radius=clamp(radius,0,121)
		if radius<5:
			body.rotation_degrees=rotationdeg
			explode(body)
			break
		await get_tree().create_timer(delta).timeout

func explode(body):
	body.dead=true
	
