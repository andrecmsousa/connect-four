extends Area2D

signal column_clicked(column_index)

@onready var highlight = $Highlight
var column_index := -1

func _ready() -> void:
	highlight.visible = false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_pressed():
		column_clicked.emit(column_index)

func _on_mouse_entered() -> void:
	highlight.visible = true

func _on_mouse_exited() -> void:
	highlight.visible = false
