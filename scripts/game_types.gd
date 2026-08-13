class_name GameTypes extends RefCounted

enum Result {
	UNDETERMINED,
	PLAYER_ONE_WINS,
	PLAYER_TWO_WINS,
	DRAW
}

enum PlayerPiece {
	NONE,
	PLAYER_ONE,
	PLAYER_TWO
}

const PLAYER_COLORS := {
	PlayerPiece.NONE: Color.GRAY,
	PlayerPiece.PLAYER_ONE: Color.YELLOW,
	PlayerPiece.PLAYER_TWO: Color.FIREBRICK
}
const ROW_COUNT := 6
const COLUMN_COUNT := 7
const CONNECT_LENGTH := 4

static func toggle_player_piece(player_piece: PlayerPiece) -> PlayerPiece:
	match player_piece:
		PlayerPiece.PLAYER_ONE:
			return PlayerPiece.PLAYER_TWO
		PlayerPiece.PLAYER_TWO:
			return PlayerPiece.PLAYER_ONE
		_:
			return PlayerPiece.NONE

static func get_player_color(player_piece: PlayerPiece) -> Color:
	return PLAYER_COLORS[player_piece]

static func player_string(player_piece: PlayerPiece) -> String:
	match player_piece:
		PlayerPiece.PLAYER_ONE:
			return "Yellow"
		PlayerPiece.PLAYER_TWO:
			return "Red"
		_:
			return "No"

static func result_string(result: Result) -> String:
	match result:
		Result.PLAYER_ONE_WINS:
			return player_string(PlayerPiece.PLAYER_ONE) + " wins!"
		Result.PLAYER_TWO_WINS:
			return player_string(PlayerPiece.PLAYER_TWO) + " wins!"
		Result.DRAW:
			return "It's a draw!"
		_:
			return ""
