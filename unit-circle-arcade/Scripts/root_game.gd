extends Node2D

var levels = []
var quit_now = true

func _ready() -> void:
	add_child(load("res://Scenes/Game States/title_screen.tscn").instantiate())
	for i in range(0,9):
		levels.append(load("res://Scenes/Levels/"+str(i)+".tscn"))
	levels.shuffle()

func state_left(id : int):
	if id==0:
		quit_now = false
		$"Info Panel".show()
		add_child(load("res://Scenes/Game States/tutorial.tscn").instantiate())
	if id==1:
		if(levels.size()>0):
			add_child(levels[0].instantiate())
			levels.remove_at(0)
		else:
			add_child(load("res://Scenes/Game States/winner_winner.tscn").instantiate())

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Quit") and quit_now) or Input.is_action_just_pressed("Force Quit"):
		get_tree().quit()
	if(Input.is_action_just_pressed("Quit") and not quit_now):
		get_tree().change_scene_to_file("res://Scenes/root_game.tscn")
