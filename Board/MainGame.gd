extends Node2D

var board_pos = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func setup_board(): 
	var board_width = Global.CELL_SIZE * Global.board_cols
	var center = get_viewport().get_visible_rect().size.x/2
	board_pos =Vector2(center - board_width/2,0) 
	var board = preload("res://MainBoard.tscn").instance()
	add_child(board)
	board.global_position=board_pos
	
func _ready():
	setup_board()
	pass 


