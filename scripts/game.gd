extends Node

@onready var pause_menu = $PauseLayer/PauseMenu

func pause_game() -> void:
	pause_menu.show()
	get_tree().paused = true

func resume_game() -> void:
	pause_menu.hide()
	get_tree().paused = false

func _ready() -> void:
	pause_menu.resume_pressed.connect(resume_game)
	pause_menu.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause_game()

func _process(delta: float) -> void:
	pass
