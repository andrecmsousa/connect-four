class_name GameTypes extends RefCounted

enum PlayerPiece {
	NONE,
	PLAYER_ONE,
	PLAYER_TWO
}

static func toggle_player_piece(player_piece: PlayerPiece) -> PlayerPiece:
	match player_piece:
		PlayerPiece.PLAYER_ONE:
			return PlayerPiece.PLAYER_TWO
		PlayerPiece.PLAYER_TWO:
			return PlayerPiece.PLAYER_ONE
		_:
			return PlayerPiece.NONE
