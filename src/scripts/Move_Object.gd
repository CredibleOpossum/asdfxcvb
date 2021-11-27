extends Node

export(NodePath) var Moveable
export var Direction = Vector2(200, 200)


func activate():
	Moveable.Position2D += Direction
