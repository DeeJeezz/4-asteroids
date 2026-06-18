class_name Bullet
extends Area2D

@export var speed: float = 350.0


func _process(delta: float) -> void:
	position += Vector2.UP.rotated(global_rotation) * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		body.take_hit()

	queue_free()
