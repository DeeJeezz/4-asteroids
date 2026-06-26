class_name Game
extends Node2D

var _player_hp: int = 3
var _player_score: int = 0


func _ready() -> void:
	randomize()
	_connect_signals()
	_setup_ui()


func _setup_ui() -> void:
	Signals.ui_hp_change_requested.emit(_player_hp)
	Signals.ui_score_change_requested.emit(_player_score)


func _connect_signals() -> void:
	Signals.player_respawn_requested.emit(Vector2.ZERO, 0.0, Vector2.ZERO)
	Signals.spawn_wave_requested.emit()
	Signals.player_hit.connect(_on_player_hit)
	Signals.add_score_requested.connect(_on_add_score_requested)


func _on_player_hit() -> void:
	_player_hp -= 1
	Signals.ui_hp_change_requested.emit(_player_hp)
	if _player_hp <= 0:
		Signals.player_death_requested.emit()


func _on_add_score_requested(score: int) -> void:
	_player_score += score
	Signals.ui_score_change_requested.emit(_player_score)
