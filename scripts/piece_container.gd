extends Node2D

@export var piece_scene: PackedScene
const PLAYER_COLORS := {
	GameTypes.PlayerPiece.NONE: Color.GRAY,
	GameTypes.PlayerPiece.PLAYER_ONE: Color.YELLOW,
	GameTypes.PlayerPiece.PLAYER_TWO: Color.FIREBRICK
}

func spawn_piece(spawn_position: Vector2, player_piece: GameTypes.PlayerPiece) -> void:
	var piece = piece_scene.instantiate()
	piece.position = spawn_position
	piece.color = PLAYER_COLORS[player_piece]
	add_child(piece)
