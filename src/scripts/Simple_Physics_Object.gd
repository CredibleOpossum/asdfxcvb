extends KinematicBody2D

var _velocity = Vector2.ZERO

export var friction = 0.1
export var force_multipler: float = 1


func _physics_process(_delta):
	_velocity = move_and_slide(_velocity)
	_velocity.x = lerp(_velocity.x, 0, friction)
	_velocity.y = lerp(_velocity.y, 0, friction)


func shoot(vector: Vector2):
	_velocity += vector * force_multipler
