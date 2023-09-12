extends Node2D

func map_to_world(coor:Vector2): 
	var world_pos = coor * Global.CELL_SIZE+Vector2(Global.HALF_CELLSIZE,Global.HALF_CELLSIZE)
	return world_pos

	
	
	pass 
func _ready():
	for row in range(Global.board_rows): 
		for col in range(Global.board_cols): 
			var pos = map_to_world(Vector2(col, row))
			var tile =  preload("res://BoardTile.tscn").instance()
			add_child(tile)
			tile.position = pos
