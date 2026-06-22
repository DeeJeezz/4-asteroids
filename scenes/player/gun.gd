class_name Gun
extends Node2D

@export var bullet_scene: PackedScene
@export var cooldown: float = 0.25

@onready var bullet_spawn_point: Marker2D = $BulletSpawnPoint


var _can_shoot: bool = true


func shoot() -> void:
	if not _can_shoot:
		return

	var bullet: Bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn_point.global_position
	bullet.global_rotation = bullet_spawn_point.global_rotation
	get_tree().current_scene.add_child(bullet)
	_can_shoot = false
	get_tree().create_timer(cooldown).timeout.connect(func () -> void: _can_shoot = true)
