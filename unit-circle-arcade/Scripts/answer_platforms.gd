extends Node2D

@export var answers_selected = 0

func _ready() -> void:
	var temp = []
	for i in get_children():
		temp.append(i.position)
	temp.shuffle()
	for i in get_children():
		i.position = temp[0]
		temp.remove_at(0)

func _process(_delta: float) -> void:
	if answers_selected==2:
		var winner = int($"Right Platform".winner.substr(7))
		get_parent().get_parent().find_child("Info Panel").victory(winner)
		answers_selected = 0
		Engine.time_scale = 0.2
		var music : AudioStreamPlayer2D = get_parent().get_parent().find_child("Game OST")
		music.pitch_scale = .6
		await get_tree().create_timer(.5).timeout
		Engine.time_scale = 1
		music.pitch_scale = 1
		get_parent().leave_state()
