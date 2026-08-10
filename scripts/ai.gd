class_name AI extends RefCounted

func choose_move(board: Board) -> int:
	var available_columns := board.get_available_columns()
	
	return available_columns.pick_random()
