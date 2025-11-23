extends Sprite2D

#TO UNCOMMENT THIS FILE DO CTRL+F AND TYPE #, THEN CLICK ON THE CODE AND THEN USE THE ARROW AND BACKSPACE TO CLEAR ALL #s QUICKLY

#
#const TESTER = preload("uid://dyx24at1yuqet")
#var dlogActive = false
 ##Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#DialogueManager.dialogue_started.connect(dlogStarted)
	#DialogueManager.dialogue_ended.connect(dlogEnded)
#
#pass  #Replace with function body.
#
#
 ##Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("dlog") and Global.entered == true and dlogActive == false:
		#DialogueManager.show_dialogue_balloon(TESTER,"start")
	#if Input.is_action_just_pressed("dlog") and Global.entered == true and dlogActive == true:
			#DialogueManager.show_dialogue_balloon(TESTER,"start").hide()
	#pass
#
#
#func _on_dlog_g_area_entered(area: Area2D) -> void:
	#Global.entered = true
#
#func _on_dlog_g_area_exited(area: Area2D) -> void:
	#Global.entered = false
	##pass  Replace with function body.
#
#
#
#func dlogStarted(TESTER):
	#print('dasdasd')
	#dlogActive = true
	##pass  Replace with function body.
	#
#func dlogEnded(TESTER):
	#await get_tree().create_timzer(0.2).timeout
	#print('fdasfadf')
	#dlogActive = false
	##pass  Replace with function body.
