class_name AI extends RefCounted

const WIN_VALUE_PER_PIECE := 250
const BLOCK_VALUE_PER_PIECE := 225

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
	
	var ai_move_result: MoveResult = hypothetical_state_ai_move.make_move_as_player(column, GameTypes.PlayerPiece.PLAYER_TWO)
	var player_move_result: MoveResult = hypothetical_state_player_move.make_move_as_player(column, GameTypes.PlayerPiece.PLAYER_ONE)
	
	if ai_move_result.result == GameTypes.Result.PLAYER_TWO_WINS:
		# 1000 for basic Connect Four
		move_value = GameTypes.CONNECT_LENGTH * WIN_VALUE_PER_PIECE
	elif player_move_result.result == GameTypes.Result.PLAYER_ONE_WINS:
		# 900 for basic Connect Four
		move_value = GameTypes.CONNECT_LENGTH * BLOCK_VALUE_PER_PIECE
	else:
		# Give higher value to central columns
		# | 1 | 2 | 3 | 4 | 3 | 2 | 1 | for basic 7-column grid
		move_value = min(GameTypes.COLUMN_COUNT - column, column + 1)
		move_value += evaluate_line_value(ai_move_result.longest_line)
		move_value += evaluate_line_value(player_move_result.longest_line)
	
	return move_value

func evaluate_line_value(line_length: int) -> int:
	# Line of 1 -> 0
	# Line of 2 -> 20 (2*10 + Line of 1)
	# Line of 3 -> 50 (3*10 + Line of 2)
	return 5 * line_length * line_length + 5 * line_length - 10
