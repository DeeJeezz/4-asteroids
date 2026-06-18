extends Node

@export var main_menu_scene: PackedScene
@export var gameplay_scene: PackedScene

var active_screen: Node = null

@onready var current_screen: Node = $CurrentScreen


func _ready() -> void:
	_connect_signals()
	_load_main_menu()


func _connect_signals() -> void:
	Signals.game_started.connect(_start_game)
	Signals.game_finished.connect(_load_main_menu)
	Signals.game_exit.connect(_exit_game)


func _load_main_menu() -> void:
	_clear_current_screen()
	active_screen = main_menu_scene.instantiate()
	current_screen.add_child(active_screen)


func _start_game() -> void:
	_clear_current_screen()
	active_screen = gameplay_scene.instantiate()
	current_screen.add_child(active_screen)


func _exit_game() -> void:
	get_tree().quit()


func _clear_current_screen() -> void:
	for child in current_screen.get_children():
		child.queue_free()
	active_screen = null
