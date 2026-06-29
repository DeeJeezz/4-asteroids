class_name Asteroid
extends Area2D

signal destroyed(asteroid: Asteroid)
signal split(asteroid: Asteroid)

@export var sprite: MaterialSprite
@export var collision_polygon: CollisionPolygon2D
@export var wrapped: Wrapped

var current_config: AsteroidConfig

var _hp: int
var _can_split: bool = false
var _rotation_velocity: float = 0.0
var _velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	body_entered.connect(take_hit)
	area_entered.connect(take_hit)


func _physics_process(delta: float) -> void:
	rotation += _rotation_velocity * delta
	global_position += _velocity * delta


func take_hit(_body: Node2D) -> void:
	_hp -= 1
	sprite.flash()
	sprite.cracks()
	if _hp <= 0:
		if _can_split:
			_split()
		else:
			_destroy()


func setup_from_config(config: AsteroidConfig) -> void:
	current_config = config

	var angle: float = randf_range(0.0, TAU)
	var speed: float = randf_range(config.min_speed, config.max_speed)

	_velocity = Vector2.RIGHT.rotated(angle) * speed
	_rotation_velocity = randf_range(config.min_rotation_speed, config.max_rotation_speed)

	# Setup sprite.
	sprite.texture = config.texture
	sprite.material = config.sprite_material.duplicate()
	# Setup collisions.
	collision_polygon.polygon = config.collision_polygon
	# Set how far offscreen wrap will be.
	wrapped.wrap_margin = config.wrap_margin

	_hp = config.hp

	# Split setup.
	_can_split = config.split_into_variants.size() > 0


func _split() -> void:
	split.emit(self)
	queue_free()


func _destroy() -> void:
	destroyed.emit(self)
	queue_free()
