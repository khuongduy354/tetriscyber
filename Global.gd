extends Node
signal still

export var CELL_SIZE = 32
var HALF_CELLSIZE = CELL_SIZE/2
export var board_rows = 14
export var board_cols = 10
var board = null
var board_width = board_cols * CELL_SIZE
var board_height = board_rows * CELL_SIZE

var tile_coordinates = []

func _ready():
	connect("still",self,"_on_still")
# still = 20 points
# 1 line = 100
# 2 lines = 300
# 3 lines = 500
# 4 lines = 800
 
func check_lines(blocktiles): 
	for y in range(0,board_rows): 
		var line_cleared =true
		for x in range(0,board_cols):
			if !tile_coordinates.has(Vector2(x,y)):
				line_cleared=false
		if line_cleared: 
			print(y)
			print("CLEAR")


func _on_still(blocktiles): 
	for tile in blocktiles.get_children(): 
		save_tile_pos(tile)
	check_lines(blocktiles)

func map_to_world(coor:Vector2): 
	var world_pos = coor * Global.CELL_SIZE+Vector2(Global.HALF_CELLSIZE,Global.HALF_CELLSIZE)
	return world_pos+board.position
func map_to_board(coor:Vector2): 
	coor -=board.position
	var board_pos = (coor- Vector2(Global.HALF_CELLSIZE, Global.HALF_CELLSIZE))/Global.CELL_SIZE
	return board_pos

func set_surrounding(): 
	for x in range(-1,board_cols+1):
		tile_coordinates.push_back(Vector2(x,board_rows))
	for y in range(-1,board_rows+1):
		tile_coordinates.push_back(Vector2(-1,y))
	for y in range(-1,board_rows+1):
		tile_coordinates.push_back(Vector2(board_cols,y))


func save_tile_pos(tile): 
	var pos = map_to_board(tile.global_position)
	tile_coordinates.push_back(pos)
	pass 

func check_tile_colliding(blocktiles,addition_pos): 
	for tile in blocktiles.get_children(): 
		var pos = map_to_board(tile.global_position+addition_pos)
		if pos in tile_coordinates: 
			return true
	return false
