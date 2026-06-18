class_name Game
extends Node2D

@onready var world: World = $World


func _ready() -> void:
	Signals.player_respawn_requested.emit()
