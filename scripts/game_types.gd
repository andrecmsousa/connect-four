class_name GameTypes extends RefCounted

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
