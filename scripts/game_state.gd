class_name GameState extends RefCounted

var board: Array[Array]
var current_player: GameTypes.PlayerPiece
var next_empty_row: Array[int]
var empty_slots: int
var current_result: GameTypes.Result

func _init() -> void:
	board = []
	
	for row in GameTypes.ROW_COUNT:
		board.append([])
		for column in GameTypes.COLUMN_COUNT:
			board[row].append(GameTypes.PlayerPiece.NONE)
	
	for column in GameTypes.COLUMN_COUNT:
		next_empty_row.append(GameTypes.ROW_COUNT - 1)
	
	current_player = GameTypes.PlayerPiece.PLAYER_ONE
	empty_slots = GameTypes.ROW_COUNT * GameTypes.COLUMN_COUNT
	current_result = GameTypes.Result.UNDETERMINED

func duplicate() -> GameState:
	var duplicated_state := GameState.new()
	
	duplicated_state.board = board.duplicate(true)
	duplicated_state.current_player = current_player
	duplicated_state.next_empty_row = next_empty_row.duplicate()
	duplicated_state.empty_slots = empty_slots
	duplicated_state.current_result = current_result
	
	return duplicated_state

func get_available_columns() -> Array[int]:
	var available_columns: Array[int] = []
	
	for column in GameTypes.COLUMN_COUNT:
		if next_empty_row[column] >= 0:
			available_columns.append(column)
	
	return available_columns

func make_move(column: int) -> int:
	if next_empty_row[column] < 0:
		return -1
	
	var new_piece_row: int = next_empty_row[column]
	
	empty_slots -= 1
	next_empty_row[column] -= 1
	board[new_piece_row][column] = current_player
	
	if WinChecker.check_win(board, new_piece_row, column):
		match current_player:
			GameTypes.PlayerPiece.PLAYER_ONE:
				current_result = GameTypes.Result.PLAYER_ONE_WINS
			GameTypes.PlayerPiece.PLAYER_TWO:
				current_result = GameTypes.Result.PLAYER_TWO_WINS
			_:
				current_result = GameTypes.Result.UNDETERMINED
	elif empty_slots == 0:
		current_result = GameTypes.Result.DRAW
	else:
		current_player = GameTypes.toggle_player_piece(current_player)
	
	return new_piece_row
