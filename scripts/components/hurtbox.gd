class_name Hurtbox
extends Area2D

signal hit(damage: int, source: Node)


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


func _on_body_entered(body: Node) -> void:
	hit.emit(1, body)
	
	
func _on_area_entered(area: Area2D) -> void:
	hit.emit(1, area.owner)
