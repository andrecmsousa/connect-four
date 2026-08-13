class_name AI extends RefCounted

func choose_move(game_state: GameState) -> int:
	var available_columns := game_state.get_available_columns()
	
	return available_columns.pick_random()
