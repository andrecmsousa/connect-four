extends Node2D

@export var column_scene: PackedScene
var board = []
var next_empty_row = []
var current_player_piece = GameTypes.PlayerPiece.NONE

const CELL_WIDTH := 80

func _ready() -> void:
	initialize_board()
	current_player_piece = GameTypes.PlayerPiece.PLAYER_ONE
	
	for i in GameTypes.COLUMN_COUNT:
		var column = column_scene.instantiate()
		
		column.column_index = i
		column.position = Vector2(i * CELL_WIDTH, 0)
		
		column.column_clicked.connect(_on_column_clicked)
		
		add_child(column)

func _on_column_clicked(column_index: int) -> void:
	if next_empty_row[column_index] >= 0:
		var new_piece_row : int = next_empty_row[column_index]
		
		next_empty_row[column_index] -= 1
		board[new_piece_row][column_index] = current_player_piece
		$PieceContainer.spawn_piece(get_cell_position(new_piece_row, column_index), current_player_piece)
		
		if WinChecker.check_win(board, new_piece_row, column_index):
			print("Win detected!")
		
		current_player_piece = GameTypes.toggle_player_piece(current_player_piece)

func initialize_board() -> void:
	board.clear()
	next_empty_row.clear()
	
	for row in GameTypes.ROW_COUNT:
		board.append([])
		for column in GameTypes.COLUMN_COUNT:
			board[-1].append(GameTypes.PlayerPiece.NONE)
			next_empty_row.append(GameTypes.ROW_COUNT - 1)

func get_cell_position(row: int, column: int) -> Vector2:
	return Vector2(column * CELL_WIDTH, row * CELL_WIDTH)
