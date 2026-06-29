class_name Bullet
extends Area2D

@export var speed: float = 350.0
@export var ttl: float = 0.75

var _lifetime: float = 0.0


func _process(delta: float) -> void:
	_lifetime += delta
	if _lifetime >= ttl:
		queue_free()


func _physics_process(delta: float) -> void:
	position += Vector2.UP.rotated(global_rotation) * speed * delta


func _on_area_entered(_area: Area2D) -> void:
	queue_free()
