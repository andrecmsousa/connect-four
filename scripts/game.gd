extends Node

@onready var pause_menu = $PauseLayer/PauseMenu

func pause_game() -> void:
	pause_menu.show()
	get_tree().paused = true

func resume_game() -> void:
	pause_menu.hide()
	get_tree().paused = false

func start_new_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func exit_game() -> void:
	get_tree().quit()

func _ready() -> void:
	pause_menu.resume_pressed.connect(resume_game)
	pause_menu.new_game_pressed.connect(start_new_game)
	pause_menu.exit_pressed.connect(exit_game)
	pause_menu.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause_game()

func _process(delta: float) -> void:
	pass
