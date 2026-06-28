class_name GameOverScreen
extends CanvasLayer


func _ready() -> void:
	visible = false


func _on_main_menu_button_button_down() -> void:
	Signals.game_finished.emit()
