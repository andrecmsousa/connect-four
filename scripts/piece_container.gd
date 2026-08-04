extends Node2D

@export var piece_scene: PackedScene

func spawn_piece(spawn_position: Vector2, player_piece: GameTypes.PlayerPiece) -> void:
	var piece = piece_scene.instantiate()
	piece.position = spawn_position
	piece.color = GameTypes.get_player_color(player_piece)
	add_child(piece)
