class_name Game extends Node

@onready var pause_menu : PauseMenu = $MenuLayer/PauseMenu
@onready var game_over_menu : GameOverMenu = $MenuLayer/GameOverMenu
@onready var board : Board = $Board

var ai := AI.new()

const MAIN_MENU_SCENE_PATH := "res://scenes/main_menu.tscn"

func pause_game() -> void:
	pause_menu.show()
	get_tree().paused = true

func resume_game() -> void:
	pause_menu.hide()
	get_tree().paused = false

func game_over(result: String) -> void:
	game_over_menu.show_result(result)
	get_tree().paused = true

func go_to_main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)

func make_ai_move() -> void:
	board.make_move(ai.choose_move(board))

func _ready() -> void:
	pause_menu.resume_pressed.connect(resume_game)
	pause_menu.main_menu_pressed.connect(go_to_main_menu)
	game_over_menu.main_menu_pressed.connect(go_to_main_menu)
	board.game_over.connect(game_over)
	pause_menu.hide()
	game_over_menu.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause_game()

func _on_turn_changed(player_piece: GameTypes.PlayerPiece) -> void:
	if player_piece == GameTypes.PlayerPiece.PLAYER_TWO:
		call_deferred("make_ai_move")
