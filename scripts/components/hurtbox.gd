class_name Hurtbox
extends Area2D

signal hit(damage: int, source: Node)

var collision_shape: Node2D


func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			collision_shape = child as CollisionShape2D
			break
		elif child is CollisionPolygon2D:
			collision_shape = child as CollisionPolygon2D
			break

	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


func set_disabled_collision_shape(disable: bool) -> void:
	if collision_shape is CollisionPolygon2D:
		(collision_shape as CollisionPolygon2D).disabled = disable
	elif collision_shape is CollisionShape2D:
		(collision_shape as CollisionShape2D).disabled = disable


func _on_body_entered(body: Node) -> void:
	hit.emit(1, body)


func _on_area_entered(area: Area2D) -> void:
	hit.emit(1, area.owner)
