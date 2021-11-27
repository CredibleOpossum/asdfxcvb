extends Area2D

export var Reset_Level = false
export(String) var Level_Path


func activate():
	if not Reset_Level:
		assert(get_tree().change_scene(Level_Path) == 0)
	else:
		assert(get_tree().reload_current_scene() == 0)
