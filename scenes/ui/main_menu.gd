extends CanvasLayer
class_name MainMenu


func _ready() -> void:
	get_tree().paused = false


func _on_start_game_button_button_down() -> void:
	Signals.game_started.emit()


func _on_quit_button_button_down() -> void:
	Signals.game_exit.emit()
