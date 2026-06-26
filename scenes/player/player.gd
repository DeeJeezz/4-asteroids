class_name Player
extends CharacterBody2D

@export_category("Movement settings")
@export var thrust_force: float = 250.0
@export var max_speed: float = 300.0
@export var rotation_speed: float = 3.5
@export var drag: float = 0.15

var _target_thrust: float = 0
var _target_torque: float = 0

@onready var gun: Gun = $Sprite2D/Gun
@onready var sprite: MaterialSprite = $Sprite2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D


func _ready() -> void:
	_connect_signals()


func _process(_delta: float) -> void:
	_handle_input()


func _physics_process(delta: float) -> void:

	var forward := Vector2.DOWN.rotated(rotation)
	velocity += forward * _target_thrust * delta
	rotation += _target_torque * delta

	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	velocity *= (1.0 - drag * delta)
	move_and_slide()


func take_hit(_damage: int, _source: Node) -> void:
	sprite.flash()
	Signals.player_hit.emit()


func _connect_signals() -> void:
	hurtbox.hit.connect(take_hit)
	Signals.player_death_requested.connect(_on_player_death_requested)


func _on_player_death_requested() -> void:
	queue_free()


func _handle_input() -> void:
	var thrust: float = Input.get_axis(&"move_up", &"move_down")
	_target_thrust = thrust * thrust_force

	var rotation_thrust: float = Input.get_axis(&"move_left", &"move_right")
	_target_torque = rotation_thrust * rotation_speed

	if Input.is_action_pressed(&"shoot"):
		gun.shoot()


func _possible_to_disable_iframes() -> bool:
	return not hurtbox.has_overlapping_bodies() and not hurtbox.has_overlapping_areas()
