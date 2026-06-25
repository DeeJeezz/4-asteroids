extends Node

signal game_started
signal game_exit
signal game_finished

signal player_respawn_requested (desired_position: Vector2, desired_rotation: float, desired_velocity: Vector2)
signal spawn_wave_requested
