class_name Warp
extends Area2D

signal warped
signal destroyed

@export var drag_force: float = 50.0
@export var warp_area_radius: float = 15.0
@export var ttl: float = 20.0

var _entered_object: Node2D
var _warping: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var ttl_timer: Timer = $TTLTimer


func _ready() -> void:
	await animation_player.animation_finished
	animation_player.play(&"pulse")
	_connect_signals()
	ttl_timer.start(ttl)
	ttl_timer.timeout.connect(_end_of_life)


func _physics_process(delta: float) -> void:
	if _entered_object:
		_drag_to_center(_entered_object, delta)


func _connect_signals() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _drag_to_center(body: Node2D, delta: float) -> void:
	body.global_position = body.global_position.move_toward(global_position, drag_force * delta)
	if not _warping:
		var body_distance_to_center: float = (body.global_position - global_position).length()
		if body_distance_to_center < warp_area_radius:
			_warp(body)


func _warp(body: Node2D) -> void:
	_warping = true
	ttl_timer.stop()
	body.reparent(sprite)
	if body_entered.is_connected(_on_body_entered):
		body_entered.disconnect(_on_body_entered)
	animation_player.play(&"warp")
	animation_player.animation_finished.connect(_on_warp_finished)


func _end_of_life() -> void:
	if body_entered.is_connected(_on_body_entered):
		body_entered.disconnect(_on_body_entered)
	animation_player.play(&"warp")
	animation_player.animation_finished.connect(_on_end_of_life)


func _on_end_of_life(_anim_name: StringName) -> void:
	destroyed.emit()
	queue_free()


func _on_warp_finished(_anim_name: StringName) -> void:
	Signals.player_respawn_requested.emit()
	warped.emit()
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
