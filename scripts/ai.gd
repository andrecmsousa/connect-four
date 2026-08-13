class_name AI extends RefCounted

func choose_move(game_state: GameState) -> int:
	var available_columns := game_state.get_available_columns()
	
	for column in available_columns:
		var hypothetical_state: GameState = game_state.duplicate()
		hypothetical_state.make_move_as_player(column, GameTypes.PlayerPiece.PLAYER_TWO)
		if hypothetical_state.current_result == GameTypes.Result.PLAYER_TWO_WINS:
			return column
	
	for column in available_columns:
		var hypothetical_state: GameState = game_state.duplicate()
		hypothetical_state.make_move_as_player(column, GameTypes.PlayerPiece.PLAYER_ONE)
		if hypothetical_state.current_result == GameTypes.Result.PLAYER_ONE_WINS:
			return column
	
	return available_columns.pick_random()
