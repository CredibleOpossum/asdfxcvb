extends Node

export(NodePath) var object


func _on_Area2D_body_entered(_body):
	get_node(object).activate()
