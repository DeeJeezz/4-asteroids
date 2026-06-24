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

var _asteroid_scenes: Array[PackedScene]


func _ready() -> void:
	_asteroid_scenes = [big_asteroid_scene, medium_asteroid_scene, small_asteroid_scene]


func create_player() -> Player:
	return player_scene.instantiate()


func create_wave(max_asteroids: int) -> Array[Asteroid]:
	var asteroids: Array[Asteroid] = []
	for _i in range(max_asteroids):
		var asteroid: Asteroid
		if randf() < big_asteroid_probability:
			asteroid = big_asteroid_scene.instantiate()
		elif randf() > big_asteroid_probability and randf() < big_asteroid_probability + medium_asteroid_probability:
			asteroid = medium_asteroid_scene.instantiate()
		else:
			asteroid = small_asteroid_scene.instantiate()
		asteroids.append(asteroid)
	return asteroids


func create_warp() -> Warp:
	return warp_scene.instantiate()
