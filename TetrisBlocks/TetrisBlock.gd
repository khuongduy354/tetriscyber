extends Node2D
var still =false 
signal still


func to_still(): 
	still = true
	emit_signal("still")
	$down_timer.stop()
	for tile in $BlockTiles.get_children(): 
		Global.save_tile_pos(tile)
func down(): 
	var next_pos =Vector2( global_position.x,global_position.y + Global.CELL_SIZE)
	var addition_pos = Vector2(0,Global.CELL_SIZE)
	if Global.check_tile_colliding($BlockTiles,addition_pos): 
		to_still() 
		return 
	var board_next_pos=Global.map_to_board(next_pos).y
	global_position = next_pos
func left(): 
	var next_pos = Vector2(global_position.x-Global.CELL_SIZE, global_position.y)
	var addition_pos = Vector2(-Global.CELL_SIZE,0)
	if Global.check_tile_colliding($BlockTiles,addition_pos): 
		return 
	global_position = next_pos
func right(): 
	var next_pos = Vector2(global_position.x+Global.CELL_SIZE,global_position.y)
	var addition_pos = Vector2(Global.CELL_SIZE,0)
	
	if Global.check_tile_colliding($BlockTiles,addition_pos): 
		return
	global_position = next_pos

func rotate_block(): 
	rotate(deg2rad(90))
func instant_down(): 
	pass
func _physics_process(delta):
	if still: 
		return
	if Input.is_action_just_pressed("instant_down"): 
		instant_down()
	if Input.is_action_just_pressed("ui_down"): 
		down()
	if Input.is_action_just_pressed("ui_up"): 
		rotate_block()
	if Input.is_action_just_pressed("ui_left"): 
		left()
	if Input.is_action_just_pressed("ui_right"): 
		right()

func _on_down_timer_timeout():
	down()
