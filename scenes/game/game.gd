class_name Game
extends Node2D

const GAME_OVER_SCREEN_VISIBILITY_DELAY: float = 0.75

var _player_hp: int = 3
var _player_score: int = 0

@onready var hud: HUD = $UI/HUD
@onready var pause_screen: PauseScreen = $UI/PauseScreen
@onready var game_over_screen: CanvasLayer = $UI/GameOverScreen


func _ready() -> void:
	randomize()
	Signals.player_respawn_requested.emit(Vector2.ZERO, 0.0, Vector2.ZERO)
	_connect_signals()
	_setup_ui()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed(&"pause"):
			Signals.game_pause_set.emit(true)


func _setup_ui() -> void:
	Signals.ui_hp_change_requested.emit(_player_hp)
	Signals.ui_score_change_requested.emit(_player_score)


func _connect_signals() -> void:
	Signals.player_death_requested.connect(_on_player_death_requested)
	Signals.spawn_wave_requested.emit()
	Signals.player_hit.connect(_on_player_hit)
	Signals.add_score_requested.connect(_on_add_score_requested)
	Signals.game_pause_set.connect(_on_game_pause_set)


func _on_player_death_requested() -> void:
	await get_tree().create_timer(GAME_OVER_SCREEN_VISIBILITY_DELAY).timeout
	game_over_screen.setup(_player_score)
	game_over_screen.show()
	hud.hide()
	if _player_score > GameController.session.score:
		GameController.session.score = _player_score
		SaveManager.save_game(GameController.session)


func _on_game_pause_set(pause: bool) -> void:
	get_tree().paused = pause
	pause_screen.visible = pause


func _on_player_hit() -> void:
	_player_hp -= 1
	Signals.ui_hp_change_requested.emit(_player_hp)
	if _player_hp <= 0:
		Signals.player_death_requested.emit()


func _on_add_score_requested(score: int) -> void:
	_player_score += score
	Signals.ui_score_change_requested.emit(_player_score)
