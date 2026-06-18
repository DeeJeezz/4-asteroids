@tool
class_name FlashingSprite
extends Sprite2D

@export var flash_duration: float = 0.15
@export_range(0, 1, 0.05) var flash_min_value: float = 0.0
@export_range(0, 1, 0.05) var flash_max_value: float = 1.0


func flash() -> void:
	var sprite_material: ShaderMaterial = material
	if not sprite_material:
		return

	var tween: Tween = create_tween()
	tween.tween_method(
		func(value: float): sprite_material.set_shader_parameter("flash_amount", value),
		flash_max_value,
		flash_min_value,
		flash_duration,
	)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array[String] = []
	if material == null:
		warnings.append("ShaderMaterial need to be set")

	return warnings
