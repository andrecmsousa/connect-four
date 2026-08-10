class_name Board extends Node2D

@export var column_scene: PackedScene
var board : Array[Array] = []
var next_empty_row : Array[int] = []
var current_player_piece := GameTypes.PlayerPiece.NONE
var empty_slots := GameTypes.COLUMN_COUNT * GameTypes.ROW_COUNT

const CELL_WIDTH := 80

signal game_over(result: String)
signal turn_changed(player_piece: GameTypes.PlayerPiece)

func _ready() -> void:
	initialize_board()
	current_player_piece = GameTypes.PlayerPiece.PLAYER_ONE
	
	for i in GameTypes.COLUMN_COUNT:
		var column : Column = column_scene.instantiate()
		
		column.column_index = i
		column.position = Vector2(i * CELL_WIDTH, 0)
		
		column.column_clicked.connect(_on_column_clicked)
		
		add_child(column)

func _on_column_clicked(column_index: int) -> void:
	make_move(column_index)

func get_available_columns() -> Array[int]:
	var available_columns : Array[int] = []
	
	for column in GameTypes.COLUMN_COUNT:
		if next_empty_row[column] >= 0:
			available_columns.append(column)
	
	return available_columns

func make_move(column_index: int) -> void:
	if next_empty_row[column_index] < 0:
		return
	
	var new_piece_row : int = next_empty_row[column_index]
	
	empty_slots -= 1
	next_empty_row[column_index] -= 1
	board[new_piece_row][column_index] = current_player_piece
	$PieceContainer.spawn_piece(get_cell_position(new_piece_row, column_index), current_player_piece)
	
	if WinChecker.check_win(board, new_piece_row, column_index):
		game_over.emit(GameTypes.player_string(current_player_piece) + " wins!")
	elif empty_slots == 0:
		game_over.emit("It's a draw!")
	else:
		current_player_piece = GameTypes.toggle_player_piece(current_player_piece)
		turn_changed.emit(current_player_piece)

func initialize_board() -> void:
	board.clear()
	next_empty_row.clear()
	
	for column in GameTypes.COLUMN_COUNT:
		next_empty_row.append(GameTypes.ROW_COUNT - 1)
	
	for row in GameTypes.ROW_COUNT:
		board.append([])
		for column in GameTypes.COLUMN_COUNT:
			board[-1].append(GameTypes.PlayerPiece.NONE)

func get_cell_position(row: int, column: int) -> Vector2:
	return Vector2(column * CELL_WIDTH, row * CELL_WIDTH)
