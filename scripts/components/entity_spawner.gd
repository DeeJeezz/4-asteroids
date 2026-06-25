class_name EntitySpawner
extends Node

@export_category("Asteroids")
@export_group("Big asteroid", "big_asteroid")
@export var big_asteroid_scene: PackedScene
@export_range(0.0, 1.0, 0.05) var big_asteroid_probability: float = 0.1
@export_group("Medium asteroid", "medium_asteroid")
@export var medium_asteroid_scene: PackedScene
@export_range(0.0, 1.0, 0.05) var medium_asteroid_probability: float = 0.15
@export_group("Small asteroid", "small_asteroid")
@export var small_asteroid_scene: PackedScene
@export_range(0.0, 1.0, 0.05) var small_asteroid_probability: float = 0.25
@export_category("Player")
@export var player_scene: PackedScene
@export_category("Warp")
@export var warp_scene: PackedScene

var _big_asteroid_prefab: Asteroid
var _medium_asteroid_prefab: Asteroid
var _small_asteroid_prefab: Asteroid
var _player_prefab: Player
var _warp_prefab: Warp


func _ready() -> void:
	_preload_prefabs()


func create_player() -> Player:
	var player: Player = _player_prefab.duplicate()
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.visible = true
	return player


func create_wave(max_asteroids: int) -> Array[Asteroid]:
	var asteroids: Array[Asteroid] = []
	for _i in range(max_asteroids):
		var asteroid: Asteroid
		if randf() < big_asteroid_probability:
			asteroid = _big_asteroid_prefab.duplicate()
		elif randf() > big_asteroid_probability and randf() < big_asteroid_probability + medium_asteroid_probability:
			asteroid = _medium_asteroid_prefab.duplicate()
		else:
			asteroid = _small_asteroid_prefab.duplicate()
		asteroid.process_mode = Node.PROCESS_MODE_INHERIT
		asteroid.visible = true
		asteroids.append(asteroid)
	return asteroids


func create_warp() -> Warp:
	var warp: Warp = _warp_prefab.duplicate()
	warp.process_mode = Node.PROCESS_MODE_INHERIT
	warp.visible = true
	return warp


func _preload_prefabs() -> void:
	_big_asteroid_prefab = big_asteroid_scene.instantiate()
	_big_asteroid_prefab.process_mode = Node.PROCESS_MODE_DISABLED
	_big_asteroid_prefab.visible = false
	add_child(_big_asteroid_prefab)

	_medium_asteroid_prefab = medium_asteroid_scene.instantiate()
	_medium_asteroid_prefab.process_mode = Node.PROCESS_MODE_DISABLED
	_medium_asteroid_prefab.visible = false
	add_child(_medium_asteroid_prefab)

	_small_asteroid_prefab = small_asteroid_scene.instantiate()
	_small_asteroid_prefab.process_mode = Node.PROCESS_MODE_DISABLED
	_small_asteroid_prefab.visible = false
	add_child(_small_asteroid_prefab)

	_player_prefab = player_scene.instantiate()
	_player_prefab.process_mode = Node.PROCESS_MODE_DISABLED
	_player_prefab.visible = false
	add_child(_player_prefab)

	_warp_prefab = warp_scene.instantiate()
	_warp_prefab.process_mode = Node.PROCESS_MODE_DISABLED
	_warp_prefab.visible = false
	add_child(_warp_prefab)
