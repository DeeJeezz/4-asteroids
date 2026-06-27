## Manager for spawning asteroids.
class_name AsteroidSpawner
extends Node

@export var big_asteroid_variants: Array[AsteroidConfig]
@export var medium_asteroid_variants: Array[AsteroidConfig]
@export var small_asteroid_variants: Array[AsteroidConfig]

@onready var asteroid_scene: PackedScene = preload("res://scenes/asteroid/asteroid.tscn")


var _asteroid_prefab: Asteroid


func _ready() -> void:
	_asteroid_prefab = asteroid_scene.instantiate()


func spawn_big_asteroid() -> Asteroid:
	return spawn_asteroid_from_config(big_asteroid_variants.pick_random())


func spawn_medium_asteroid() -> Asteroid:
	return spawn_asteroid_from_config(medium_asteroid_variants.pick_random())


func spawn_small_asteroid() -> Asteroid:
	return spawn_asteroid_from_config(small_asteroid_variants.pick_random())


func spawn_asteroid_from_config(config: AsteroidConfig) -> Asteroid:
	var asteroid: Asteroid = _asteroid_prefab.duplicate()
	asteroid.setup_from_config(config)
	return asteroid
