extends Node
signal still
signal clear_line
signal scored


export var CELL_SIZE = 32
var HALF_CELLSIZE = CELL_SIZE/2
export var board_rows = 14
export var board_cols = 10
var board = null
var game = null
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
func remove_global_tiles(coor): 
	for i in range(0, tile_coordinates.size()):
		if tile_coordinates[i] == coor: 
			tile_coordinates.remove(i)
			return
	pass
func shift_global_tiles(offset,lower_y): 
	for i in range(tile_coordinates.size()): 
		var tile = tile_coordinates[i]
		if !is_surround_tile(tile):
			if tile_coordinates[i].y <= lower_y: 
				tile_coordinates[i]+=offset
func is_surround_tile(tile): 
	if tile.x==-1 or tile.y ==-1 or tile.x==board_cols or tile.y==board_rows: 
		return true 
	return false

func check_lines(blocktiles): 
	var lines_cleared_list = []
	for y in range(0,board_rows): 
		var line_cleared =true
		for x in range(0,board_cols):
			if !tile_coordinates.has(Vector2(x,y)):
				line_cleared=false
		if line_cleared: 
			lines_cleared_list.push_back(y)
	
	if lines_cleared_list.size()>0: 
		var length = lines_cleared_list.size()
	# clear lines	
		for y in lines_cleared_list: 
			for x in range(0,board_cols): 
				for block in game.get_node("TileBlocks").get_children(): 
					block.clear_tile(Vector2(x,y))
					remove_global_tiles(Vector2(x,y))
	# shift
	
		for i in range(lines_cleared_list.size()):
			for block in game.get_node("TileBlocks").get_children(): 
				for tile in block.get_node("BlockTiles").get_children(): 
					var pos = map_to_board(tile.global_position)
					if pos.y < lines_cleared_list[length-1]: 
						tile.global_position.y+=CELL_SIZE
		shift_global_tiles(Vector2(0,length),lines_cleared_list[length-1])
		
		
	emit_signal("clear_line",lines_cleared_list.size())



func _on_still(blocktiles): 
	for tile in blocktiles.get_children(): 
		save_tile_pos(tile)
	check_lines(blocktiles)
	emit_signal("scored",5)
	game.spawn_block()
	print(tile_coordinates)

func map_to_world(coor:Vector2): 
	var world_pos = coor * Global.CELL_SIZE+Vector2(Global.HALF_CELLSIZE,Global.HALF_CELLSIZE)
	return world_pos+board.position
func map_to_board(coor:Vector2): 
	coor -=board.position
	var board_pos = (coor- Vector2(Global.HALF_CELLSIZE, Global.HALF_CELLSIZE))/Global.CELL_SIZE
	return Vector2(floor(board_pos.x),floor(board_pos.y))

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
