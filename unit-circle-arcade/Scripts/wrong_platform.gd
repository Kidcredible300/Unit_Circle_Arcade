extends Node
@export var answer : String

func _ready() -> void:
	$Description.text = answer

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_parent().answers_selected +=1

func _on_area_2d_body_exited(body: Node2D) -> void:
	get_parent().answers_selected -=1
