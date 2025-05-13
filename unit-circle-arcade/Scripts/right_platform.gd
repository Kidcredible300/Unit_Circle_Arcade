extends Node
var winner = ""
var players_here = []
@export var answer : String

func _ready() -> void:
	$Description.text = answer

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_parent().answers_selected +=1
	if winner == "": winner = body.name
	if body.name not in players_here: players_here.append(body.name)

func _on_area_2d_body_exited(body: Node2D) -> void:
	get_parent().answers_selected -=1
	players_here.remove_at(players_here.find(body.name))
	if players_here.size()>0: winner = players_here[0]
	else: winner = ""
