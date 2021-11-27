extends Node

export var fake = false
export var push_dist = 50


func _on_Node2D_body_entered(body):
	body.can_jump = true
	if not fake:
		self.queue_free()
	else:
		self.position.x += push_dist
