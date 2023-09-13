extends Node

export var CELL_SIZE = 32
var HALF_CELLSIZE = CELL_SIZE/2
export var board_rows = 14
export var board_cols = 10
var board = null
var board_width = board_cols * CELL_SIZE
var board_height = board_rows * CELL_SIZE
func map_to_world(coor:Vector2): 
	var world_pos = coor * Global.CELL_SIZE+Vector2(Global.HALF_CELLSIZE,Global.HALF_CELLSIZE)
	return world_pos+board.position
func map_to_board(coor:Vector2): 
	coor -=board.position
	var board_pos = (coor- Vector2(Global.HALF_CELLSIZE, Global.HALF_CELLSIZE))/Global.CELL_SIZE
	return board_pos

var tile_coordinates = []
func set_surrounding(): 
	for x in range(-1,board_cols+1):
		tile_coordinates.push_back(Vector2(x,board_rows))
	for y in range(-1,board_rows+1):
		tile_coordinates.push_back(Vector2(-1,y))
	for y in range(-1,board_rows+1):
		tile_coordinates.push_back(Vector2(board_cols,y))
	print(tile_coordinates)


func save_tile_pos(tile): 
	var pos = map_to_board(tile.global_position)
	tile_coordinates.push_back(pos)
	print("still",pos)
	pass 

func check_tile_colliding(blocktiles,addition_pos): 
	for tile in blocktiles.get_children(): 
		var pos = map_to_board(tile.global_position+addition_pos)
		print(pos)
		if pos in tile_coordinates: 
			print("collided",pos)
			return true
	return false
