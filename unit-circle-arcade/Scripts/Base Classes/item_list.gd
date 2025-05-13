extends Item
## Base Class for all item lists in the game (Hand, Shop, etc)
class_name Item_List

## Controls the way that the sorted elements are displayed. Type 0 is Left-to-Right, Type 1 is Top-to-Bottom
@export var sort_type : int
## Value that controls the minimum value on the controlled axis that items can be placed at
@export var min_pos : int
## Value that controls the maximum value on the controlled axis that items can be placed at
@export var max_pos : int
## Value that controls the constant value on the uncontrolled axis that items can be placed at
@export var constant_pos : int

## Uses an Insertion Sort Algorithm to Sort a Given Array, Returns the Sorted Array
func insertion_sort(arr: Array) -> Array:
	for i in range(1, arr.size()):
		var temp = arr[i]
		var j = i-1
		while j>=0 and arr[j].value < temp.value:
			arr[j+1] = arr[j]
			j-=1
		arr[j+1] = temp
	return arr

## Places all of the children of the object sorted in order
func place_children() -> void:
	var array = insertion_sort(get_children())
	for i in range(array.size()-1, -1, -1):
		var pos : Vector2
		if(array.size()==1): pos = Vector2(int((min_pos+max_pos)/2), constant_pos)
		else: pos = Vector2(min_pos + abs(min_pos-max_pos)/(array.size()-1)*i, constant_pos)
		if(sort_type==0):
			array[i].x = pos.x
			array[i].y = pos.y
		elif(sort_type==1):
			array[i].x = pos.y
			array[i].y = pos.x
		array[i].edit_position()

## Places all of the children of the object sorted in order, but it looks cooler.
func fancy_place_children() -> void:
	var array = insertion_sort(get_children())
	var center = int((min_pos+max_pos)/2)
	var new_min = -70*array.size() + center
	if(new_min<min_pos): new_min=min_pos
	var new_max = 70*array.size() + center
	if(new_max>max_pos): new_max=max_pos
	for i in range(array.size()-1, -1, -1):
		var pos : Vector2
		if(array.size()==1): pos = Vector2(int((min_pos+max_pos)/2), constant_pos)
		else: pos = Vector2(new_min + abs(new_min-new_max)/(array.size()-1)*i, constant_pos)
		if(sort_type==0):
			array[i].x = pos.x
			array[i].y = pos.y
		elif(sort_type==1):
			array[i].x = pos.y
			array[i].y = pos.x
		array[i].edit_position()
