class_name GameOverMenu extends Control

signal main_menu_pressed

func show_result(result_text: String) -> void:
	$MenuPanel/CenterContainer/MenuContainer/Result.text = result_text
	show()

func _on_main_menu_button_pressed() -> void:
	main_menu_pressed.emit()
