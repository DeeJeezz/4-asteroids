class_name AsteroidConfig
extends Resource

@export var texture: Texture2D
@export var collision_shape: Shape2D
@export var hp: int
@export_category("Physics settings")
@export var min_speed: float = 50.0
@export var max_speed: float = 150.0
@export var min_rotation_speed: float = -2.0
@export var max_rotation_speed: float = 2.0
