class_name World
extends Node2D

@export var player_scene: PackedScene

@onready var entities: Node2D = $Entities


func _ready() -> void:
	_connect_signals()


func spawn_player() -> void:
	var player: Player = player_scene.instantiate()
	player.position = Vector2(randi_range(0, GameController.SCREEN_SIZE.x), randi_range(0, GameController.SCREEN_SIZE.y))
	entities.add_child(player)


func _connect_signals() -> void:
	Signals.player_respawn_requested.connect(spawn_player)
