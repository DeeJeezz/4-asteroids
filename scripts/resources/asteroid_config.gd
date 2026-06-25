class_name AsteroidConfig
extends Resource

@export_category("Appearance settings")
@export var texture: Texture2D
@export var collision_shape: Shape2D
@export_category("Behaviour settings")
@export var hp: int
@export_category("Physics settings")
@export var min_speed: float = 50.0
@export var max_speed: float = 150.0
@export var min_rotation_speed: float = -2.0
@export var max_rotation_speed: float = 2.0
@export_category("Split settings")
@export_range(0, 4, 1, "prefer_slider") var min_splits: int = 1
@export_range(0, 4, 1, "prefer_slider") var max_splits: int = 2
@export var split_into_variants: Array[AsteroidConfig]
