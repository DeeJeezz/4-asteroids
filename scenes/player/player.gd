class_name Player
extends CharacterBody2D

@export_category("Movement settings")
@export var thrust_force: float = 250.0
@export var max_speed: float = 300.0
@export var rotation_speed: float = 3.5
@export var drag: float = 0.15

var _target_thrust: float = 0
var _target_torque: float = 0
var _can_move: bool = true

@onready var gun: Gun = $Sprite2D/Gun
@onready var sprite: MaterialSprite = $Sprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var move_sfx: AudioStreamPlayer2D = $SFX/MoveSFX
@onready var damage_sfx: AudioStreamPlayer2D = $SFX/DamageSFX
@onready var explosion_sfx: AudioStreamPlayer2D = $SFX/ExplosionSFX


func _ready() -> void:
	_connect_signals()


func _physics_process(delta: float) -> void:
	_handle_input()
	if _can_move:
		if _target_thrust != 0:
			var forward := Vector2.DOWN.rotated(rotation)
			velocity += forward * _target_thrust * delta
		if _target_torque != 0:
			rotation += _target_torque * delta

	velocity *= (1.0 - drag * delta)
	velocity = velocity.limit_length(max_speed)
	move_and_slide()


func take_hit(_damage: int, _source: Node) -> void:
	sprite.flash()
	damage_sfx.play()
	Signals.player_hit.emit()


func _connect_signals() -> void:
	hurtbox.hit.connect(take_hit)
	Signals.player_death_requested.connect(_on_player_death_requested)


func _on_player_death_requested() -> void:
	explosion_sfx.play()
	collision_polygon.set_deferred("disabled", true)
	hurtbox.set_deferred("monitoring", false)
	_can_move = false
	explosion.play()
	explosion.animation_finished.connect(queue_free)


func _handle_input() -> void:
	var thrust: float = Input.get_axis(&"move_up", &"move_down")
	_target_thrust = thrust * thrust_force

	var rotation_thrust: float = Input.get_axis(&"move_left", &"move_right")
	_target_torque = rotation_thrust * rotation_speed
	
	if thrust != 0 or rotation_thrust != 0:
		if not move_sfx.playing:
			move_sfx.play()
	else:
		move_sfx.stop()

	if Input.is_action_pressed(&"shoot"):
		gun.shoot()
