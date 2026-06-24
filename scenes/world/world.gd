## World controller class.
##
## Controls world generation, player (re-)spawn, asteroids and warps spawn.
class_name World
extends Node2D

@export_category("Wave generation settings")
## Max amount of asteroids, generated per wave.
@export var max_asteroids_per_wave: int = 5
## On what percentage of remaining asteroids new wave will be generated.
@export_range(0.0, 1.0, 0.05) var new_asteroids_wave_threshold: float = 0.25
## How far from screen X asteroids will be spawned.
@export var min_wave_spawn_screen_offset: Vector2 = Vector2(-200, -200)
## How far from screen Y asteroids will be spawned.
@export var max_wave_spawn_screen_offset: Vector2 = Vector2(-100, -100)
@export_category("Player spawn settings")
## How far from screen borders player will be spawned.
@export var player_screen_border_offset: float = 100.0
@export_category("Warp spawn settings")
## How far from screen borders warps will be spawned.
@export var warp_screen_border_offset: float = 50.0
## Min time before next warp will be spawned.
@export var min_warp_spawn_time: float = 20.0
## Max time before next warp will be spawned.
@export var max_warp_spawn_time: float = 35.0
## Timer for controlling warp spawn.
@export var warp_spawn_timer: Timer

# Current asteroids counter.
var _current_asteroids: int = 0

# Entities container. Contains every spawned node.
@onready var entities: Node2D = $Entities
# Entity spawner node.
@onready var entity_spawner: EntitySpawner = $EntitySpawner


func _ready() -> void:
	_connect_signals()

	# Warps.
	_start_warp_spawn_timer()
	warp_spawn_timer.timeout.connect(spawn_warp)


## Generate player node. Places at random [member Player.position].[br]
## Max and min position controlled by [param World.player_screen_border_offset].
func spawn_player() -> void:
	var player: Player = entity_spawner.create_player()
	player.position = Vector2(
		randf_range(player_screen_border_offset, GameController.SCREEN_SIZE.x - player_screen_border_offset),
		randf_range(player_screen_border_offset, GameController.SCREEN_SIZE.y - player_screen_border_offset),
	)
	entities.add_child(player)


## Generates wave of asteroids.[br]
## Asteroids spawn position controlled by [param World.min_wave_spawn_screen_offset] 
## and [param World.max_wave_spawn_screen_offset].
func generate_wave() -> void:
	var asteroids: Array[Asteroid] = entity_spawner.create_wave(max_asteroids_per_wave - _current_asteroids)
	for asteroid: Asteroid in asteroids:
		asteroid.position = Vector2(
			randf_range(min_wave_spawn_screen_offset.x, max_wave_spawn_screen_offset.x),
			randf_range(min_wave_spawn_screen_offset.y, max_wave_spawn_screen_offset.y),
		)
		asteroid.destroyed.connect(_on_asteroid_destroyed)
		entities.call_deferred("add_child", asteroid)
		_current_asteroids += 1
	print_debug("Generated new wave of asteroids")


func spawn_warp() -> void:
	var warp: Warp = entity_spawner.create_warp()
	warp.position = Vector2(
		randf_range(warp_screen_border_offset, GameController.SCREEN_SIZE.x - warp_screen_border_offset),
		randf_range(warp_screen_border_offset, GameController.SCREEN_SIZE.y - warp_screen_border_offset),
	)
	entities.add_child(warp)
	entities.move_child(warp, 0)
	print_debug("Generated warp")


# Processing asteroid destruction.
func _on_asteroid_destroyed(asteroid: Asteroid) -> void:
	_current_asteroids -= 1
	prints("Current asteroids", _current_asteroids)
	print_debug("Destroyed asteroid ", asteroid)
	if _current_asteroids < ceili(max_asteroids_per_wave * new_asteroids_wave_threshold):
		generate_wave()


func _start_warp_spawn_timer() -> void:
	warp_spawn_timer.start(randf_range(min_warp_spawn_time, max_warp_spawn_time))


# Connects global signals.
func _connect_signals() -> void:
	Signals.player_respawn_requested.connect(spawn_player)
	Signals.spawn_wave_requested.connect(generate_wave)
