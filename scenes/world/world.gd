class_name World
extends Node2D

@export_group("Wave generation settings")
@export var max_asteroids: int = 5
@export_group("Player spawn settings")
@export var screen_border_offset: float = 100.0

var _current_asteroids: int = 0

@onready var entities: Node2D = $Entities
@onready var entity_spawner: EntitySpawner = $EntitySpawner


func _ready() -> void:
	_connect_signals()


func spawn_player() -> void:
	var player: Player = entity_spawner.create_player()
	player.position = Vector2(
		randf_range(screen_border_offset, GameController.SCREEN_SIZE.x - screen_border_offset),
		randf_range(screen_border_offset, GameController.SCREEN_SIZE.y - screen_border_offset),
	)
	entities.add_child(player)


func generate_wave() -> void:
	var asteroids: Array[Asteroid] = entity_spawner.create_wave(max_asteroids - _current_asteroids)
	for asteroid: Asteroid in asteroids:
		asteroid.position = Vector2(
			randf_range(0, GameController.SCREEN_SIZE.x),
			randf_range(0, GameController.SCREEN_SIZE.y),
		)
		asteroid.destroyed.connect(_on_asteroid_destroyed)
		entities.call_deferred("add_child", asteroid)
	for child in entities.get_children():
		if child is Asteroid:
			_current_asteroids += 1
	print_debug("Generated new wave of asteroids")


func _on_asteroid_destroyed(asteroid: Asteroid) -> void:
	_current_asteroids -= 1
	print_debug("Destroyed asteroid ", asteroid)
	if _current_asteroids < max_asteroids:
	#if _current_asteroids < ceili(max_asteroids * 0.25):
		generate_wave()


func _connect_signals() -> void:
	Signals.player_respawn_requested.connect(spawn_player)
	Signals.spawn_wave_requested.connect(generate_wave)
