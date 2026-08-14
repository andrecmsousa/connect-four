class_name AI extends RefCounted

func choose_move(game_state: GameState) -> int:
	var available_columns := game_state.get_available_columns()
	
	var best_move_value = 0
	var columns_with_best_move_value = []
	
	for column in available_columns:
		var move_value = evaluate_move(game_state, column)
		if move_value > best_move_value:
			best_move_value = move_value
			columns_with_best_move_value = [column]
		elif move_value == best_move_value:
			columns_with_best_move_value.append(column)
	
	return columns_with_best_move_value.pick_random()

func evaluate_move(game_state: GameState, column: int) -> int:
	var move_value: int = 0
	
	var hypothetical_state_ai_move: GameState = game_state.duplicate()
	var hypothetical_state_player_move: GameState = game_state.duplicate()
	
	var ai_move_row: int = hypothetical_state_ai_move.make_move_as_player(column, GameTypes.PlayerPiece.PLAYER_TWO)
	var player_move_row: int = hypothetical_state_player_move.make_move_as_player(column, GameTypes.PlayerPiece.PLAYER_ONE)
	
	if hypothetical_state_ai_move.current_result == GameTypes.Result.PLAYER_TWO_WINS:
		move_value = 1000
	elif hypothetical_state_player_move.current_result == GameTypes.Result.PLAYER_ONE_WINS:
		move_value = 500
	else:
		move_value = min(GameTypes.COLUMN_COUNT - column, column + 1)
		move_value += max(0, (WinChecker.check_longest_line(hypothetical_state_ai_move.board, ai_move_row, column) - 1) * 30 - 10)
		move_value += max(0, (WinChecker.check_longest_line(hypothetical_state_player_move.board, player_move_row, column) - 1) * 30 - 10)
	
	return move_value
