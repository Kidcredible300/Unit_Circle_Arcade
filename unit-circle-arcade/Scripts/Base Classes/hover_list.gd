extends Item_List
## Extension of Item List, has capability of moving left and right between it's children.
class_name Hover_List
## The currently selected index
var index : int

## Moves the selected index one to the left
func go_left() -> void:
	var array = insertion_sort(get_children())
	if(index==-1): return
	array[index].hover()
	index-=1
	index_check()
	array[index].hover()

## Moves the selected index one to the right
func go_right() -> void:
	var array = insertion_sort(get_children())
	if(index==-1): return
	array[index].hover()
	index+=1
	index_check()
	array[index].hover()

## Goes through all indexes, and sets their hover state to the boolean
func hover_all(state : bool) -> void:
	var array = insertion_sort(get_children())
	for i in array:
		if(i.hovered!=state):
			i.hovered=state
			i.edit_position()

# Goes through all indexes, and sets their selected state to the boolean
func select_all(state : bool) -> void:
	var array = insertion_sort(get_children())
	for i in array:
		i.selected=state
		i.edit_position()

## Internal Function, used to check if the index is valid
func index_check() -> void:
	if(index>=get_child_count()): index=0
	if(index<0): index=get_child_count()-1
