extends Control

func _on_start_button_pressed() -> void:
	print("Start a new game!")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
