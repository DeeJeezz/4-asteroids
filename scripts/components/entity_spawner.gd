## Manager for spawning different entities.
class_name EntitySpawner
extends Node

@export_category("Asteroids")
@export var asteroid_spawner: AsteroidSpawner
@export var big_asteroid_probability: float = 0.2
@export var medium_asteroid_probability: float = 0.2
@export var small_asteroid_probability: float = 0.2
@export_category("Player")
@export var player_scene: PackedScene
@export_category("Warp")
@export var warp_scene: PackedScene


func generate_asteroids_wave(big_asteroids: int, medium_asteroids: int, small_asteroids: int) -> Array[Asteroid]:
	var asteroids: Array[Asteroid] = []
	for _i in range(big_asteroids):
		asteroids.append(asteroid_spawner.spawn_big_asteroid())
		await get_tree().physics_frame
	for _i in range(medium_asteroids):
		asteroids.append(asteroid_spawner.spawn_medium_asteroid())
		await get_tree().physics_frame
	for _i in range(small_asteroids):
		asteroids.append(asteroid_spawner.spawn_small_asteroid())
		await get_tree().physics_frame

	return asteroids


func create_player() -> Player:
	return player_scene.instantiate()


func create_warp() -> Warp:
	return warp_scene.instantiate()
