class_name Asteroid
extends CharacterBody2D

signal destroyed(asteroid: Asteroid)
signal split(asteroid: Asteroid)

const HURTBOX_COLLISION_SHAPE_ENLARGEMENT_COEFF: float = 1.025

@export var sprite: MaterialSprite
@export var collision_shape: CollisionShape2D
@export var hurtbox: Hurtbox
@export var hurtbox_collision_shape: CollisionShape2D
@export var wrapped: Wrapped

var current_config: AsteroidConfig

var _hp: int
var _can_split: bool = false
var _rotation_velocity: float = 0.0


func _ready() -> void:
	hurtbox.hit.connect(take_hit)


func _physics_process(delta: float) -> void:
	rotation += _rotation_velocity * delta

	move_and_slide()


func take_hit(damage: int, _source: Node) -> void:
	_hp -= damage
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

	velocity = Vector2.RIGHT.rotated(angle) * speed
	_rotation_velocity = randf_range(config.min_rotation_speed, config.max_rotation_speed)

	# Setup sprite.
	sprite.texture = config.texture
	sprite.material = config.sprite_material.duplicate()
	# Setup collisions.
	collision_shape.shape = config.collision_shape
	hurtbox_collision_shape.shape = config.collision_shape
	# Set how far offscreen wrap will be.
	wrapped.wrap_margin = config.wrap_margin

	# Enlarge hurtbox collision.
	hurtbox_collision_shape.scale *= HURTBOX_COLLISION_SHAPE_ENLARGEMENT_COEFF

	_hp = config.hp

	# Split setup.
	_can_split = config.split_into_variants.size() > 0


func _split() -> void:
	split.emit(self)
	queue_free()


func _destroy() -> void:
	destroyed.emit(self)
	queue_free()
