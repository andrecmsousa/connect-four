extends Node2D

@export var column_scene: PackedScene

const COLUMN_COUNT := 7
const COLUMN_WIDTH := 80

func _ready() -> void:
	for i in COLUMN_COUNT:
		var column = column_scene.instantiate()
		
		column.column_index = i
		column.position = Vector2(i * COLUMN_WIDTH, 0)
		
		column.column_clicked.connect(_on_column_clicked)
		
		add_child(column)

func _on_column_clicked(column_index: int) -> void:
	print("Column ", column_index, " was clicked!")
