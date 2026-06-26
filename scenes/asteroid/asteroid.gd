class_name Asteroid
extends CharacterBody2D

signal destroyed(asteroid: Asteroid)
signal split(asteroid: Asteroid)

@export var sprite: MaterialSprite
@export var collision_shape: CollisionShape2D
@export var hurtbox: Hurtbox
@export var hurtbox_collision_shape: CollisionShape2D
@export var wrapped: Wrapped

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
	var angle: float = randf_range(0.0, TAU)
	var speed: float = randf_range(config.min_speed, config.max_speed)

	velocity = Vector2.RIGHT.rotated(angle) * speed
	_rotation_velocity = randf_range(config.min_rotation_speed, config.max_rotation_speed)

	sprite.texture = config.texture
	collision_shape.shape = config.collision_shape
	hurtbox_collision_shape.shape = config.collision_shape
	hurtbox_collision_shape.scale *= 1.05
	_hp = config.hp
	wrapped.wrap_margin = config.wrap_margin
	sprite.material = config.sprite_material


func _split() -> void:
	split.emit(self)
	queue_free()


func _destroy() -> void:
	destroyed.emit(self)
	queue_free()
