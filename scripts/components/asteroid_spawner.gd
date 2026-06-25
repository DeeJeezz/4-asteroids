## Manager for spawning asteroids.
class_name AsteroidSpawner
extends Node

@export var big_asteroid_variants: Array[AsteroidConfig]
@export var medium_asteroid_variants: Array[AsteroidConfig]
@export var small_asteroid_variants: Array[AsteroidConfig]

@onready var asteroid_scene: PackedScene = preload("res://scenes/asteroid/asteroid.tscn")


func spawn_big_asteroid() -> Asteroid:
	return _spawn_asteroid(big_asteroid_variants.pick_random())


func spawn_medium_asteroid() -> Asteroid:
	return _spawn_asteroid(medium_asteroid_variants.pick_random())


func spawn_small_asteroid() -> Asteroid:
	return _spawn_asteroid(small_asteroid_variants.pick_random())


func _spawn_asteroid(config: AsteroidConfig) -> Asteroid:
	var asteroid: Asteroid = asteroid_scene.instantiate()
	asteroid.setup_from_config(config)
	return asteroid
