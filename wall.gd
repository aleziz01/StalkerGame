extends StaticBody2D

const DLOG = preload("uid://x4u0q357x04g")
var dlogActive = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.dialogue_started.connect(dlogStarted)
	DialogueManager.dialogue_ended.connect(dlogStarted)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dlog") and Global.entered == true and not dlogActive:
		DialogueManager.show_dialogue_balloon(DLOG,"start")

	pass




func dlogStarted(DLOG):
	print("TRUEEEEEE")
	dlogActive = true
	
func dlogEnded(DLOG):
	print("falseeeeeee")
	await get_tree().create_timer(0.2).timeout
	dlogActive = false
