extends Node

signal game_started
signal game_exit
signal game_finished
signal game_pause_set(pause: bool)

signal player_respawn_requested(desired_position: Vector2, desired_rotation: float, desired_velocity: Vector2)
signal player_death_requested
signal player_hit
signal add_score_requested(score: int)

signal spawn_wave_requested

#region UI Signals
signal ui_hp_change_requested(hp: int)
signal ui_score_change_requested(score: int)
#endregion
