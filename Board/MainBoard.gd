extends Node2D


	
	
func _ready():
	for row in range(Global.board_rows): 
		for col in range(Global.board_cols): 
			var pos = Global.map_to_world(Vector2(col, row))
			var tile =  preload("res://BoardTile.tscn").instance()
			add_child(tile)
			tile.global_position = pos+position
