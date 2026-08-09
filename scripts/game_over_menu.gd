extends Control

signal new_game_pressed
signal exit_pressed

func show_result(result_text: String) -> void:
	$MenuPanel/CenterContainer/MenuContainer/Result.text = result_text
	show()

func _on_start_button_pressed() -> void:
	new_game_pressed.emit()

func _on_exit_button_pressed() -> void:
	exit_pressed.emit()
