class_name MainMenu
extends CanvasLayer

@onready var high_score_h_box_container: HBoxContainer = $Control/HighScoreHBoxContainer
@onready var high_score_label: Label = $Control/HighScoreHBoxContainer/HighScoreLabel


func _ready() -> void:
	get_tree().paused = false
	if GameController.session.score == 0:
		high_score_h_box_container.hide()
	else:
		high_score_label.text = "%d" % GameController.session.score


func _on_start_game_button_button_down() -> void:
	Signals.game_started.emit()


func _on_quit_button_button_down() -> void:
	Signals.game_exit.emit()
