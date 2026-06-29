class_name Saucer
extends CharacterBody2D

@export_category("Tracking target settings")
@export var tracking_rotation_speed: float = 0.9
@export_range(0, 360, 1, "radians_as_degrees") var shooting_angle: float

var _target: Player

@onready var sprite: MaterialSprite = $Sprite2D
@onready var gun: Gun = $Sprite2D/Gun
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var move_sfx: AudioStreamPlayer2D = $SFX/MoveSFX
@onready var damage_sfx: AudioStreamPlayer2D = $SFX/DamageSFX
@onready var explosion_sfx: AudioStreamPlayer2D = $SFX/ExplosionSFX


func _ready() -> void:
	_connect_signals()
	_target = get_tree().get_first_node_in_group(&"player")
	look_at(_target.global_position)


func _physics_process(delta: float) -> void:
	_track_target(delta)


func take_hit(_damage: int, _source: Node2D) -> void:
	sprite.flash()
	damage_sfx.play()


func _connect_signals() -> void:
	hurtbox.hit.connect(take_hit)


func _request_shot() -> void:
	gun.shoot()


func _track_target(delta: float) -> void:
	var direction: Vector2 = _target.global_position - global_position
	var angle_to_target: float = direction.angle()
	global_rotation = lerp_angle(global_rotation, angle_to_target, tracking_rotation_speed * delta)

	if abs(global_rotation - angle_to_target) < shooting_angle:
		_request_shot()
