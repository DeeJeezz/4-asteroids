class_name Game
extends Node2D


func _ready() -> void:
	randomize()
	Signals.player_respawn_requested.emit(Vector2.ZERO, 0.0, Vector2.ZERO)
	Signals.spawn_wave_requested.emit()
