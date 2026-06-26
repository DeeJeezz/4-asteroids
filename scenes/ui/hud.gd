class_name HUD
extends CanvasLayer

@onready var hp_label: Label = $Panel/HBoxContainer/HPLabel
@onready var score_label: Label = $Panel/HBoxContainer2/ScoreLabel


func _ready() -> void:
	_connect_signals()


func _connect_signals() -> void:
	Signals.ui_score_change_requested.connect(_on_score_change_requested)
	Signals.ui_hp_change_requested.connect(_on_hp_change_requested)


func _on_score_change_requested(score: int) -> void:
	score_label.text = "%d" % score


func _on_hp_change_requested(hp: int) -> void:
	hp_label.text = "%d" % hp
