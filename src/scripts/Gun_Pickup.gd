extends Node


func _on_Area2D_body_entered(body):
	body.enable_gun()
	self.queue_free()
