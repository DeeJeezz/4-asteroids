class_name Asteroid
extends CharacterBody2D

signal destroyed(asteroid: Asteroid)
signal split(asteroid: Asteroid)

var _hp: int
var _can_split: bool = false
var _rotation_velocity: float = 0.0

#@onready var sprite: MaterialSprite = $Sprite2D
#@onready var collision_shape: CollisionShape2D = $CollisionShape2D
#@onready var hurtbox: Hurtbox = $Hurtbox
#@onready var hurtbox_collision_shape: CollisionShape2D = $Hurtbox/CollisionShape2D


func _ready() -> void:
	$Hurtbox.hit.connect(take_hit)


func _physics_process(delta: float) -> void:
	rotation += _rotation_velocity * delta

	move_and_slide()


func take_hit(damage: int, _source: Node) -> void:
	_hp -= damage
	$Sprite2D.flash()
	$Sprite2D.cracks()
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

	$Sprite2D.texture = config.texture
	$CollisionShape2D.shape = config.collision_shape
	$Hurtbox/CollisionShape2D.shape = config.collision_shape
	$Hurtbox/CollisionShape2D.scale *= 1.05
	_hp = config.hp
	_can_split = config.split_into_variants.size() > 0


func _split() -> void:
	split.emit(self)
	queue_free()


func _destroy() -> void:
	destroyed.emit(self)
	queue_free()
