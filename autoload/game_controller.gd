extends Node

var SCREEN_SIZE: Vector2
var session: SaveManager.Session


func _ready() -> void:
	SCREEN_SIZE = get_viewport().get_visible_rect().size
	session = SaveManager.load_game()
