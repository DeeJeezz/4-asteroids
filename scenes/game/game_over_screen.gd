class_name GameOverScreen
extends CanvasLayer

@onready var score_label: Label = $Panel/ScoreHBoxContainer/ScoreLabel


func _ready() -> void:
	visible = false


func setup(score: int) -> void:
	score_label.text = "%d" % score


func _on_main_menu_button_button_down() -> void:
	Signals.game_finished.emit()
