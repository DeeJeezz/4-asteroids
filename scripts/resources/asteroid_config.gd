class_name AsteroidConfig
extends Resource

@export_category("Appearance settings")
@export var texture: Texture2D
@export var collision_shape: Shape2D
@export var sprite_material: ShaderMaterial
@export_category("Behaviour settings")
@export var hp: int
@export_range(0.0, 360.0) var wrap_margin: float
@export_category("Physics settings")
@export var min_speed: float = 50.0
@export var max_speed: float = 150.0
@export var min_rotation_speed: float = -2.0
@export var max_rotation_speed: float = 2.0
