class_name Player
extends Actor

export var gun_enabled = false
export var gun_power = Vector2(500, 500)
export var gun_recoil = Vector2(250, 250)
export var shot_cooldown = 1500

var can_jump = false
var last_shot = -shot_cooldown
var recoil_velocity = Vector2.ZERO
var can_shoot = false

export var gun_particles: PackedScene
onready var gun_node = $Node2D
onready var gun_raycast = $Node2D/RayCast2D


func _ready():
	if gun_enabled:
		enable_gun()


func spawn_particle_effect(hit_position: Vector2):
	var temp = gun_particles.instance()
	self.get_parent().add_child(temp)
	temp.global_position = hit_position


func _physics_process(_delta):
	if gun_enabled and OS.get_ticks_msec() - last_shot > shot_cooldown:
		gun_node.modulate = "ffffff"
		can_shoot = true
	else:
		gun_node.modulate = "ff0000"
		can_shoot = false

	if Input.is_action_pressed("shoot_gun") and can_shoot:
		last_shot = OS.get_ticks_msec()
		recoil_velocity += ((self.position - get_global_mouse_position()).normalized() * gun_recoil)
		if gun_raycast.get_collider():
			spawn_particle_effect(gun_raycast.get_collision_point())
			if gun_raycast.get_collider().get_collision_layer_bit(2):
				gun_raycast.get_collider().shoot(
					(gun_raycast.get_collision_point() - self.position).normalized() * gun_power
				)

	gun_node.rotation = get_angle_to(get_global_mouse_position())
	if abs(gun_node.rotation_degrees) > 90:
		$"Node2D/gun image".scale.y = abs($"Node2D/gun image".scale.y) * -1
		$"Node2D/gun image".position.y = abs($"Node2D/gun image".position.y) * -1
	else:
		$"Node2D/gun image".scale.y = abs($"Node2D/gun image".scale.y)
		$"Node2D/gun image".position.y = abs($"Node2D/gun image".position.y)
	if is_on_floor():
		can_jump = true
	var direction = get_direction(can_jump)
	if direction.y == -1:
		can_jump = false

	var is_jump_interrupted = Input.is_action_just_released("move_up") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)

	_velocity = move_and_slide(_velocity + recoil_velocity, Vector2.UP)

	if _velocity.y != 0:
		recoil_velocity.y = lerp(recoil_velocity.y, 0, 0.1)
	else:
		recoil_velocity.y = 0

	_velocity -= recoil_velocity

	recoil_velocity.x = lerp(recoil_velocity.x, 0, 0.1)
	recoil_velocity.y = lerp(recoil_velocity.y, 0, 0.1)

	if Input.is_action_just_pressed("reset"):
		assert(get_tree().reload_current_scene() == 0)


func get_direction(jump_allowed):
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1 if jump_allowed and Input.is_action_just_pressed("move_up") else 0
	)


func calculate_move_velocity(linear_velocity, direction, speed, is_jump_interrupted):
	var velocity = linear_velocity
	velocity.x = direction.x * speed.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y *= 0.6
	return velocity


func enable_gun():
	gun_node.visible = true
	gun_enabled = true
