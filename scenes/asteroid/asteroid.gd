class_name Asteroid
extends CharacterBody2D

@export var asteroid_configs: Array[AsteroidConfig]

var _hp: int
var _rotation_velocity: float = 0.0

@onready var sprite: MaterialSprite = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var hurtbox_collision_shape: CollisionShape2D = $Hurtbox/CollisionShape2D


func _ready() -> void:
	
	hurtbox.hit.connect(take_hit)

	var config: AsteroidConfig = asteroid_configs.pick_random()

	var angle: float = randf_range(0.0, TAU)
	var speed: float = randf_range(config.min_speed, config.max_speed)

	velocity = Vector2.RIGHT.rotated(angle) * speed
	_rotation_velocity = randf_range(config.min_rotation_speed, config.max_rotation_speed)

	sprite.texture = config.texture
	collision_shape.shape = config.collision_shape
	hurtbox_collision_shape.shape = config.collision_shape
	hurtbox_collision_shape.scale *= 1.05
	_hp = config.hp


func _physics_process(delta: float) -> void:
	rotation += _rotation_velocity * delta
	
	move_and_slide()


func take_hit(damage: int, _source: Node) -> void:
	_hp -= damage
	sprite.flash()
	sprite.cracks()
	if _hp <= 0:
		queue_free()
