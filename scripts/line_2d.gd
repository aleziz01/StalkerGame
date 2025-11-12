extends Line2D

var amplitude=0.0

func _process(delta: float) -> void:
	amplitude = lerp(amplitude,70.0,12*delta)
	points[1]=Vector2(amplitude,amplitude)
