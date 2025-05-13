extends Label

func _ready() -> void:
	text = get_parent().get_parent().find_child("Info Panel").winner()
