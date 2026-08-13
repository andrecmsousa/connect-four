class_name MainMenu extends Control

const GAME_SCENE_PATH := "res://scenes/game.tscn"

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE_PATH)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
