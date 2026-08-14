class_name MoveResult extends RefCounted

var player: GameTypes.PlayerPiece
var row: int
var column: int
var longest_line: int
var game_result: GameTypes.Result

func _init(player: GameTypes.PlayerPiece, row: int, column: int, longest_line: int, game_result: GameTypes.Result) -> void:
	self.player = player
	self.row = row
	self.column = column
	self.longest_line = longest_line
	self.game_result = game_result
