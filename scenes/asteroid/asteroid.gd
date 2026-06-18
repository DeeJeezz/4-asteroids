@tool
class_name Asteroid
extends RigidBody2D

@export var asteroid_resources: Array[AsteroidResource]

var _hp: int

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	sprite.material = sprite.material.duplicate()
	
	var resource: AsteroidResource = asteroid_resources.pick_random()
	sprite.texture = resource.texture
	collision_shape.shape = resource.collision_shape
	_hp = resource.hp


func take_hit() -> void:
	_hp -= 1
	_flash()
	if _hp <= 0:
		queue_free()


func _flash():
	var sprite_material: ShaderMaterial = sprite.material
	
	var tween: Tween = create_tween()
	tween.tween_method(
		func(value: float): sprite_material.set_shader_parameter("flash_amount", value),
		1.0,
		0.0,
		0.15
	)
