extends Node

@onready var pause_menu = $MenuLayer/PauseMenu
@onready var game_over_menu = $MenuLayer/GameOverMenu
@onready var game_board = $Board

func pause_game() -> void:
	pause_menu.show()
	get_tree().paused = true

func resume_game() -> void:
	pause_menu.hide()
	get_tree().paused = false

func start_new_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func game_over(result: String) -> void:
	game_over_menu.show_result(result)
	get_tree().paused = true

func exit_game() -> void:
	get_tree().quit()

func _ready() -> void:
	pause_menu.resume_pressed.connect(resume_game)
	pause_menu.new_game_pressed.connect(start_new_game)
	pause_menu.exit_pressed.connect(exit_game)
	game_over_menu.new_game_pressed.connect(start_new_game)
	game_over_menu.exit_pressed.connect(exit_game)
	game_board.game_over.connect(game_over)
	pause_menu.hide()
	game_over_menu.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause_game()
