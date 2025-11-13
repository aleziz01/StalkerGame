extends Node2D

var levels=[preload("res://scenes/zaton.tscn")]
var levelCount=0
func _ready() -> void:
	#michael play the story intro here
	
	#and queueFree whatever child you added here
	#this is my part, where i initialize the first level (zaton)
	changeLevel(0)

func changeLevel(useless):
	print(levelCount)
	if levelCount<levels.size():
		var levelInstance=levels[levelCount].instantiate()
		levelCount+=1
		add_child(levelInstance)
	else:
		win()

func win():
	pass
