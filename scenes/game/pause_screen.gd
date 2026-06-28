class_name PauseScreen
extends CanvasLayer


func _ready() -> void:
	visible = false


func _on_resume_game_button_button_down() -> void:
	Signals.game_pause_set.emit(false)


func _on_main_menu_button_button_down() -> void:
	Signals.game_finished.emit()
