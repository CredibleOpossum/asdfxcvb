extends Node2D

export var frame_loop = 30.0

export var maximum = 1.0
export var minimum = 0.75

var frame_count = 1.0
var dir = 1


func _physics_process(_delta):
	if frame_count == frame_loop or frame_count == 0:
		dir *= -1
	frame_count += dir
	var value = minimum + (frame_count * (maximum - minimum)) / frame_loop
	self.modulate = Color(0, value, 0)
