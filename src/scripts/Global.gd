extends Node

var offset = 0


func _ready():
	pass


func get_timer():
	var miliseconds = OS.get_ticks_msec() - offset

	var minutes = miliseconds / (60 * 1000)
	var seconds = str((miliseconds - (60 * 1000 * minutes)) / 1000)
	minutes = str(minutes)

	return (
		("0" + minutes if len(minutes) == 1 else minutes)
		+ ":"
		+ ("0" + seconds if len(seconds) == 1 else seconds)
	)
