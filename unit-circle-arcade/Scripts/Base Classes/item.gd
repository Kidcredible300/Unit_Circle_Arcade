extends Node2D
## Base Class for all items in the game (Cards, Item Lists, etc)
class_name Item

## The value that the item is sorted by
@export var value : int
## Controls if the item is in the hover state
var hovered = false
## Value that the y-level is decreased by during the hover state
@export var hover_increase : int
## Controls if the item is in the selected state
var selected = false
## Value that the y-level is decreased by during the selected state
@export var select_increase : int
## Keeps track of the x value that is the default
@onready var x = position.x
## Keeps track of the y value that is the default
@onready var y = position.y

## Toggles the selected variable, and adjusts the position
func select() -> void:
	selected = !selected
	edit_position()

## Toggles the hovered variable, and adjusts the position
func hover() -> void:
	hovered = !hovered
	edit_position()

## Changes the position of the item based on if it's hovered or selected
func edit_position() -> void:
	var temp = y
	if(hovered):
		temp-=hover_increase
	if(selected):
		temp-=select_increase
	position = Vector2(x, temp);
