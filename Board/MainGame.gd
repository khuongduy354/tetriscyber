extends Node2D

var board_pos = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var bomb_spawn_rate = 50
var current_block = null 
var rng =RandomNumberGenerator.new()
func pick_random_block(): 
	var i = rng.randi()%7
#	var i = 0
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
func spawn_bomb(): 
	var bomb = preload("res://TetrisBlocks/Bombs.tscn").instance()
	$TileBlocks.add_child(bomb)
	bomb.global_position=$spawn_pos.global_position
	current_block = bomb
func spawn_block(): 
	var block = pick_random_block()
	$TileBlocks.add_child(block)
	block.global_position=$spawn_pos.global_position
	current_block = block 
func pause_game(): 
	for child in $TileBlocks.get_children(): 
		child.set_physics_process(false)
		child.get_node("down_timer").stop()
func resume_game(): 
	for child in $TileBlocks.get_children(): 
		child.set_physics_process(true)
		child.get_node("down_timer").start()
		
func setup_board(): 
	Global.set_surrounding()
	var board_width = Global.CELL_SIZE * Global.board_cols
	var center = get_viewport().get_visible_rect().size.x/2
	board_pos =Vector2(center - board_width/2,100) 

	var board = preload("res://Board/MainBoard.tscn").instance()
	Global.board=board
	add_child(board)
	board.position=board_pos
	
func start_game(): 
	Global.game=self
	var center = get_viewport().get_visible_rect().size.x/2
	$spawn_pos.global_position =Vector2(center,132)	
	setup_board()
	spawn_manager()

func spawn_manager(): 
	if rng.randi()%5==0:
		spawn_bomb()
	else:
		spawn_block()


func _ready():
	rng.randomize()
	start_game()





func _on_Play_pressed():
	if Global.game_over: 
		Global.reset_game()
		Global.game_over= false
	else: 
		resume_game()


func _on_Pause_pressed():
	pause_game()
