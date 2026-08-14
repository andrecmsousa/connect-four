class_name Board extends Node2D

@export var column_scene: PackedScene
var game_state: GameState

const CELL_WIDTH := 80

signal game_over(result: String)
signal turn_changed(player_piece: GameTypes.PlayerPiece)

func _ready() -> void:
	game_state = GameState.new()
	
	for column_index in GameTypes.COLUMN_COUNT:
		var column: Column = column_scene.instantiate()
		
		column.column_index = column_index
		column.position = Vector2(column_index * CELL_WIDTH, 0)
		
		column.column_clicked.connect(_on_column_clicked)
		
		add_child(column)

func _on_column_clicked(column_index: int) -> void:
	make_move(column_index)

func make_move(column_index: int) -> void:
	var move_result: MoveResult = game_state.commit_current_player_move(column_index)
	if move_result == null:
		return
	
	$PieceContainer.spawn_piece(get_cell_position(move_result.row, column_index), move_result.player)
	
	if move_result.game_result != GameTypes.Result.UNDETERMINED:
		game_over.emit(GameTypes.result_string(move_result.game_result))
	else:
		turn_changed.emit(game_state.current_player)

func get_cell_position(row: int, column: int) -> Vector2:
	return Vector2(column * CELL_WIDTH, row * CELL_WIDTH)
