extends Node2D

@onready var spawn_point: Node2D = $SpawnPoint
var player = preload("res://scenes/player.tscn")
# Called when the node enters the scene tree for the first time.
var playerInstance=null
func _ready() -> void:
	playerInstance=player.instantiate()
	add_child(playerInstance)
	playerInstance.global_position=spawn_point.global_position
	$EndPoint.body_entered.connect(get_parent().changeLevel)


	
	
	
	pass # Replace with function body.
