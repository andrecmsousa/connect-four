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

func get_available_columns() -> Array[int]:
	var available_columns: Array[int] = []
	
	for column in GameTypes.COLUMN_COUNT:
		if next_empty_row[column] >= 0:
			available_columns.append(column)
	
	return available_columns

func get_next_available_row(column: int) -> int:
	return next_empty_row[column]

func make_move(column: int) -> void:
	if next_empty_row[column] < 0:
		return
	
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

func get_current_player() -> GameTypes.PlayerPiece:
	return current_player

func get_current_result() -> GameTypes.Result:
	return current_result
