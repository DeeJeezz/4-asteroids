class_name Warp
extends Area2D

@export var drag_force: float = 50.0
@export var warp_area_radius: float = 15.0

var _entered_object: Node2D
var _warping: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(delta: float) -> void:
	if _entered_object:
		_drag_to_center(_entered_object, delta)


func _drag_to_center(body: Node2D, delta: float) -> void:
	body.global_position = body.global_position.move_toward(global_position, drag_force * delta)
	if not _warping:
		if (body.global_position - global_position).length() < warp_area_radius:
			_warp(body)


func _warp(body: Node2D) -> void:
	_warping = true
	body.reparent(sprite)
	body_entered.disconnect(_on_body_entered)
	animation_player.play(&"warp")
	animation_player.animation_finished.connect(_on_warp_finished)


func _on_warp_finished(_anim_name: StringName) -> void:
	Signals.player_respawn_requested.emit()
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if _warping:
		return

	_entered_object = body


func _on_body_exited(body: Node2D) -> void:
	if _warping:
		return

	if body == _entered_object:
		_entered_object = null
