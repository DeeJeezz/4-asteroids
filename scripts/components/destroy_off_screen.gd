class_name DestroyOffScreen
extends Node2D

var _margin: Vector2 = Vector2(64, 64)
var _viewpoint_rect: Rect2 = Rect2(Vector2.ZERO - _margin, GameController.SCREEN_SIZE + _margin)
var _parent: Node2D


func _ready() -> void:
	_parent = get_parent()


func _process(_delta: float) -> void:
	if not _viewpoint_rect.has_point(global_position):
		_parent.queue_free()
