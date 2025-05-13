extends Node2D

## Base class for different menus or states that the game can be in.
class_name Game_State
## Integer used to control the state machine inside of it's children.
var state : int
## Integer used to identify the gamestate, used in leaveState()
@export var id : int

## When the state is finished, give it's ID to the root game, then deletes itself
func leave_state() -> void:
	get_parent().state_left(id)
	get_parent().remove_child(self)
