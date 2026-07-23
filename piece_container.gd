extends Node2D

@export var piece_scene: PackedScene

func spawn_piece(spawn_position: Vector2) -> void:
	var piece = piece_scene.instantiate()
	piece.position = spawn_position
	add_child(piece)
