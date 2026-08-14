class_name WinChecker extends RefCounted

enum Line {
	HORIZONTAL,
	VERTICAL,
	RISING_DIAGONAL,
	FALLING_DIAGONAL
}

enum Direction {
	TOP,
	TOP_RIGHT,
	RIGHT,
	BOTTOM_RIGHT,
	BOTTOM,
	BOTTOM_LEFT,
	LEFT,
	TOP_LEFT
}

const LINE_TO_DIRECTIONS := {
	Line.HORIZONTAL: [Direction.LEFT, Direction.RIGHT],
	Line.VERTICAL: [Direction.BOTTOM, Direction.TOP],
	Line.RISING_DIAGONAL: [Direction.BOTTOM_LEFT, Direction.TOP_RIGHT],
	Line.FALLING_DIAGONAL: [Direction.TOP_LEFT, Direction.BOTTOM_RIGHT]
}

const DIRECTION_TO_VECTOR := {
	Direction.TOP: Vector2i(-1, 0),
	Direction.TOP_RIGHT: Vector2i(-1, 1),
	Direction.RIGHT: Vector2i(0, 1),
	Direction.BOTTOM_RIGHT: Vector2i(1, 1),
	Direction.BOTTOM: Vector2i(1, 0),
	Direction.BOTTOM_LEFT: Vector2i(1, -1),
	Direction.LEFT: Vector2i(0, -1),
	Direction.TOP_LEFT: Vector2i(-1, -1)
}

static func check_win(board: Array, piece_row: int, piece_column: int) -> bool:
	return check_longest_line(board, piece_row, piece_column) >= GameTypes.CONNECT_LENGTH

static func check_longest_line(board: Array, piece_row: int, piece_column: int) -> int:
	return max(
		_check_line(board, piece_row, piece_column, Line.HORIZONTAL),
		_check_line(board, piece_row, piece_column, Line.VERTICAL),
		_check_line(board, piece_row, piece_column, Line.RISING_DIAGONAL),
		_check_line(board, piece_row, piece_column, Line.FALLING_DIAGONAL)
	)

static func _check_line(board: Array, piece_row: int, piece_column: int, line_type: Line) -> int:
	return 1 + _check_direction(board, piece_row, piece_column, LINE_TO_DIRECTIONS[line_type][0]) \
			 + _check_direction(board, piece_row, piece_column, LINE_TO_DIRECTIONS[line_type][1])

static func _check_direction(board: Array, piece_row: int, piece_column: int, direction: Direction) -> int:
	var player_piece: GameTypes.PlayerPiece = board[piece_row][piece_column]
	
	var current_row: int = piece_row + DIRECTION_TO_VECTOR[direction].x
	var current_column: int = piece_column + DIRECTION_TO_VECTOR[direction].y
	
	var piece_count := 0
	while current_column < GameTypes.COLUMN_COUNT and current_column >= 0 and current_row < GameTypes.ROW_COUNT and current_row >= 0:
		if board[current_row][current_column] != player_piece or piece_count == GameTypes.CONNECT_LENGTH - 1:
			break
		
		piece_count += 1 
		current_row += DIRECTION_TO_VECTOR[direction].x
		current_column += DIRECTION_TO_VECTOR[direction].y
	
	return piece_count
