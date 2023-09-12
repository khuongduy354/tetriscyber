extends Node2D

var board_pos = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_block = null 
func spawn_block(): 
	var block = preload("res://TetrisBlocks/CBlock.tscn").instance()
	add_child(block)
	block.global_position=$spawn_pos.global_position
	current_block = block 
	current_block.connect("still",self,"spawn_block")
func setup_board(): 
	var board_width = Global.CELL_SIZE * Global.board_cols
	var center = get_viewport().get_visible_rect().size.x/2
#	board_pos =Vector2(center - board_width/2,0) 
	board_pos =Vector2(0,0) 

	var board = preload("res://Board/MainBoard.tscn").instance()
	add_child(board)
	board.global_position=board_pos
	
func _ready():
	setup_board()
	spawn_block()
	pass 


