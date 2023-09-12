extends Node

export var CELL_SIZE = 32
var HALF_CELLSIZE = CELL_SIZE/2
export var board_rows = 20 
export var board_cols = 10

var board_width = board_cols * CELL_SIZE
var board_height = board_rows * CELL_SIZE
func map_to_world(coor:Vector2): 
	var world_pos = coor * Global.CELL_SIZE+Vector2(Global.HALF_CELLSIZE,Global.HALF_CELLSIZE)
	return world_pos
func map_to_board(coor:Vector2): 
	var board_pos = coor/Global.CELL_SIZE - Vector2(Global.HALF_CELLSIZE, Global.HALF_CELLSIZE)
	return board_pos
