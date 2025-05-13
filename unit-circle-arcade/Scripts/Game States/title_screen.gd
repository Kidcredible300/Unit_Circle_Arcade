extends Game_State
var p1_ready = false
var p2_ready = false

func _process(_delta: float) -> void:
	if !(p1_ready and p2_ready):
		if(Input.is_action_just_pressed("Red P1")):
			p1_ready = true
			$"P1 Ready/Label".text = "Ready!"
		if(Input.is_action_just_pressed("Red P2")):
			p2_ready = true
			$"P2 Ready/Label".text = "Ready!"
	elif($Start.hidden): $Start.show()
	if(p1_ready and p2_ready and Input.is_action_just_pressed("Start")):
		leave_state()
