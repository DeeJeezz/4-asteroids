class_name MaterialSprite
extends Sprite2D

@export_group("Flash settings", "flash")
@export var flash_material: ShaderMaterial
@export var flash_duration: float = 0.15
@export_range(0, 1, 0.05) var flash_min_value: float = 0.0
@export_range(0, 1, 0.05) var flash_max_value: float = 1.0
@export_group("IFrames settings", "iframes")
@export var iframes_material: ShaderMaterial
@export var iframes_duration: float = 0.3
@export var iframes_loops: int = 6
@export_range(0, 1, 0.05) var iframes_min_value: float = 0.0
@export_range(0, 1, 0.05) var iframes_max_value: float = 1.0


func _ready() -> void:
	if flash_material:
		flash_material = flash_material.duplicate()
	if iframes_material:
		iframes_material = iframes_material.duplicate()


func flash() -> Tween:
	material = flash_material
	var tween: Tween = create_tween()
	tween.tween_method(
		func(value: float) -> void: material.set_shader_parameter("flash_amount", value),
		flash_max_value,
		flash_min_value,
		flash_duration,
	)
	return tween


func iframes() -> Tween:
	material = iframes_material
	var tween: Tween = create_tween()
	tween.set_loops(iframes_loops)
	tween.tween_method(
		func(value: float) -> void: material.set_shader_parameter("iframe_amount", value),
		iframes_min_value,
		iframes_max_value,
		iframes_duration / 2,
	)
	tween.tween_method(
		func(value: float) -> void: material.set_shader_parameter("iframe_amount", value),
		iframes_max_value,
		iframes_min_value,
		iframes_duration / 2,
	)
	return tween
