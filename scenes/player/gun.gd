class_name Gun
extends Node2D

@export var bullet_scene: PackedScene
@export var cooldown: float = 0.25

@onready var bullet_spawn_point: Marker2D = $BulletSpawnPoint
@onready var shoot_sfx: AudioStreamPlayer2D = $ShootSFX


var _can_shoot: bool = true
var _bullet_prefab: Bullet


func _ready() -> void:
	_bullet_prefab = bullet_scene.instantiate()


func shoot() -> void:
	if not _can_shoot:
		return

	var bullet: Bullet = _bullet_prefab.duplicate()
	bullet.global_position = bullet_spawn_point.global_position
	bullet.global_rotation = bullet_spawn_point.global_rotation
	get_tree().current_scene.add_child(bullet)
	shoot_sfx.play()
	_can_shoot = false
	get_tree().create_timer(cooldown).timeout.connect(func () -> void: _can_shoot = true)
