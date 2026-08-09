extends Control

signal resume_pressed
signal new_game_pressed
signal exit_pressed

func _on_resume_button_pressed() -> void:
	resume_pressed.emit()

func _on_start_button_pressed() -> void:
	new_game_pressed.emit()

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()
