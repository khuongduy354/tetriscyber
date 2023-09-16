extends Node
signal still
signal clear_line
signal scored


export var CELL_SIZE = 32
var game_over = false 
var HALF_CELLSIZE = CELL_SIZE/2
export var board_rows = 14
export var board_cols = 10
var board = null
var game = null
var board_width = board_cols * CELL_SIZE
var board_height = board_rows * CELL_SIZE

var tile_coordinates = []

var score_list=[]

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
func shift_global_tiles(base_line): 
	for i in range(tile_coordinates.size()): 
		var tile = tile_coordinates[i]
		if !is_surround_tile(tile):
			if tile.y < base_line: 
				tile_coordinates[i].y+=1
func is_surround_tile(tile): 
	if tile.x==-1 or tile.y ==-1 or tile.x==board_cols or tile.y==board_rows: 
		return true 
	return false
func drop_tile(base_line): 
	# drop real blocks 
	for block in game.get_node("TileBlocks").get_children(): 
		for tile in block.get_node("BlockTiles").get_children(): 
			var pos = map_to_board(tile.global_position)
			if pos.y < base_line: 
				tile.global_position.y+=CELL_SIZE
	# drop array
	shift_global_tiles(base_line)
	
	pass 
func check_lines(blocktiles): 
	# get all lines
	var lines_cleared_list = []
	for y in range(0,board_rows): 
		var line_cleared =true
		for x in range(0,board_cols):
			if !tile_coordinates.has(Vector2(x,y)):
				line_cleared=false
		if line_cleared: 
			lines_cleared_list.push_back(y)
	
	var length = lines_cleared_list.size()
	if length>0:
		print("run") 
	# clear lines	
		for y in lines_cleared_list: 
			for x in range(0,board_cols): 
				for block in game.get_node("TileBlocks").get_children(): 
					block.clear_tile(Vector2(x,y))
					remove_global_tiles(Vector2(x,y))
	# shift
		# for each height 
		# -> shift any cell above that height 
		for i in range(lines_cleared_list.size()):
			var base_line = lines_cleared_list[i] 
			drop_tile(base_line)
		emit_signal("clear_line",lines_cleared_list.size())

func game_over(): 
	game_over=true
	var score = game.get_node("CanvasLayer").get_score()
	score_list.push_back(score)
	game.get_node("CanvasLayer").load_to_leaderboard()
func check_fail(tile): 
	for x in range(board_cols): 
		var pos = Vector2(x,0)
		if map_to_board(tile.global_position) == pos: 
			game_over()
			emit_signal("game_over")
			return true 
	return false
					

func _on_still(blocktiles): 
	for tile in blocktiles.get_children(): 
		if check_fail(tile): 
			return 
		save_tile_pos(tile)

	
	check_lines(blocktiles)
	emit_signal("scored",5)
	game.spawn_block()
	print("BREAK")
	for pos in tile_coordinates: 
		if !is_surround_tile(pos): 
			print(pos)

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
	print(pos)
	if !tile_coordinates.has(pos):
		tile_coordinates.push_back(pos)
	pass 
func check_tile_colliding_rotation(blocktiles,deg):
	blocktiles.rotate(deg2rad(deg)) 
	for tile in blocktiles.get_children(): 
		var pos = map_to_board(tile.global_position)
		if pos in tile_coordinates: 
			blocktiles.rotate(deg2rad(-deg)) 
			return true
	return false
func check_tile_colliding(blocktiles,addition_pos): 
	for tile in blocktiles.get_children(): 
		var pos = map_to_board(tile.global_position+addition_pos)
		if pos in tile_coordinates: 
			return true
	return false
	
func reset_game(): 
	game.get_node("CanvasLayer").reset_score()
	tile_coordinates=[]
	for tile in game.get_node("TileBlocks").get_children(): 
		game.get_node("TileBlocks").remove_child(tile)
	game.start_game()
	
