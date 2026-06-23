class_name Game
extends Node2D


func _ready() -> void:
	randomize()
	Signals.player_respawn_requested.emit()
	Signals.spawn_wave_requested.emit()
