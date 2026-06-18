class_name Player
extends RigidBody2D

@export_category("Movement settings")
@export var thrust_force: float = 100.0
@export var torque_force: float = 100

var _target_thrust: float = 0
var _target_torque: float = 0

@onready var gun: Gun = $Sprite2D/Gun


func _process(_delta: float) -> void:
	_handle_input()


func _physics_process(_delta: float) -> void:
	apply_central_force(Vector2(0, _target_thrust).rotated(rotation))
	apply_torque(_target_torque)


func _handle_input() -> void:
	var thrust: float = Input.get_axis("move_up", "move_down")
	_target_thrust = thrust * thrust_force

	var rotation_thrust: float = Input.get_axis("move_left", "move_right")
	_target_torque = torque_force * rotation_thrust

	if Input.is_action_pressed("shoot"):
		gun.shoot()
