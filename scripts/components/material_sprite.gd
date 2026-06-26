class_name MaterialSprite
extends Sprite2D

@export_group("Flash settings", "hit_flash")
@export var hit_flash_duration: float = 0.15
@export_range(0, 1, 0.05) var hit_flash_min_value: float = 0.0
@export_range(0, 1, 0.05) var hit_flash_max_value: float = 1.0


func flash() -> void:
	material.set_shader_parameter(&"use_hit_flash", true)
	var tween: Tween = create_tween()
	tween.tween_method(
		func(value: float) -> void: material.set_shader_parameter(&"hit_flash_amount", value),
		hit_flash_max_value,
		hit_flash_min_value,
		hit_flash_duration,
	)
	tween.finished.connect(func() -> void: material.set_shader_parameter(&"use_hit_flash", false))


func cracks() -> void:
	material.set_shader_parameter(&"use_cracks", true)
	if material.get_shader_parameter(&"crack_seed") == 0.0:
		material.set_shader_parameter(&"crack_seed", randf())
	if material.get_shader_parameter(&"crack_amount") < 1.0:
		material.set_shader_parameter(&"crack_amount", material.get_shader_parameter(&"crack_amount") + 0.1)
