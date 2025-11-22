extends Node2D


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("entity") && !body.dead:
		spin(body)

func spin(body):
	var radius=121
	while true:
		await get_tree().create_timer(get_process_delta_time())
		
