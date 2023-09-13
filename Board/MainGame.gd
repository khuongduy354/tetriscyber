extends Node2D

var board_pos = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_block = null 
var rng =RandomNumberGenerator.new()
func pick_random_block(): 
	var i = rng.randi()%7
	var scene = ""
	match i: 
		0: 
			scene="res://TetrisBlocks/CBlock.tscn"
		1: 
			scene="res://TetrisBlocks/IBlock.tscn"
		2: 
			scene="res://TetrisBlocks/JBlock.tscn"
		3: 
			scene="res://TetrisBlocks/LBlock.tscn"
		4: 
			scene="res://TetrisBlocks/SBlock.tscn"
		5: 
			scene="res://TetrisBlocks/TBlock.tscn"
		6: 
			scene="res://TetrisBlocks/ZBlock.tscn"
	var block = load(scene).instance()
	return block
func spawn_block(): 
	var block = pick_random_block()
	add_child(block)
	block.global_position=$spawn_pos.global_position
	current_block = block 
	current_block.connect("still",self,"spawn_block")
func setup_board(): 
	Global.set_surrounding()
	var board_width = Global.CELL_SIZE * Global.board_cols
	var center = get_viewport().get_visible_rect().size.x/2
#	board_pos =Vector2(center - board_width/2,0) 
#	board_pos =Vector2(0,0) 

	var board = preload("res://Board/MainBoard.tscn").instance()
	add_child(board)
#	board.global_position=board_pos
	
func _ready():
	setup_board()
	spawn_block()
	rng.randomize()

	pass 


