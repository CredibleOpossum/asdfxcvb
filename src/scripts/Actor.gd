class_name Actor
extends KinematicBody2D

export var speed = Vector2(150.0, 350.0)
export var gravity = 500

const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2.ZERO


func _physics_process(delta):
	_velocity.y += gravity * delta
