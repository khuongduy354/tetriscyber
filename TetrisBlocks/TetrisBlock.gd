extends Node2D
var still =false 
export var is_bomb=false
signal still
func _ready(): 
	if is_bomb:
		$down_timer.wait_time = Global.bomb_timer
	pass 
func get_tile_from_pos(coor): 
	for tile in $BlockTiles.get_children(): 
		if Global.map_to_board(tile.global_position) == coor:
			return tile
	return null
func clear_tile(coor): 
	var tile = get_tile_from_pos(coor)
	if tile:
		$BlockTiles.remove_child(tile)
		tile.queue_free()
		if $BlockTiles.get_child_count() == 0: 
			self.queue_free()
func to_still(): 
	still = true
	Global.emit_signal("still",$BlockTiles,self)
	$down_timer.stop()
var is_right =false
var is_left  =false
var rotating = false 

func down(): 
	if rotating:
		return 
	var next_pos =Vector2( $BlockTiles.global_position.x,$BlockTiles.global_position.y + Global.CELL_SIZE)
	var addition_pos = Vector2(0,Global.CELL_SIZE)
	if Global.check_tile_colliding($BlockTiles,addition_pos): 
		to_still() 
		return 
	$BlockTiles.global_position = next_pos
func left():
	var next_pos = Vector2($BlockTiles.global_position.x-Global.CELL_SIZE, $BlockTiles.global_position.y)
	var addition_pos = Vector2(-Global.CELL_SIZE,0)
	if Global.check_tile_colliding($BlockTiles,addition_pos): 
		return 
	$BlockTiles.global_position = next_pos
func right(): 
	var next_pos = Vector2($BlockTiles.global_position.x+Global.CELL_SIZE,$BlockTiles.global_position.y)
	var addition_pos = Vector2(Global.CELL_SIZE,0)
	
	if Global.check_tile_colliding($BlockTiles,addition_pos): 
		return
	$BlockTiles.global_position = next_pos
func rotate_block(): 
	rotating = true 
	Global.check_tile_colliding_rotation($BlockTiles,90)
	for child in $BlockTiles.get_children(): 
		var pos = Global.map_to_board(child.global_position)
	rotating = false
	

func _physics_process(delta):
	if still or rotating or is_bomb: 
		return
	if Input.is_action_pressed("ui_down"): 
		if $down_cooldown.is_stopped():
			down()
			$down_timer.stop()
			$down_timer.start()
			$down_cooldown.start()
	if Input.is_action_just_pressed("ui_up"): 
		if !rotating: 
			rotate_block()
	if Input.is_action_pressed("ui_left"): 
		if $down_cooldown.is_stopped() :
			left()
			$down_cooldown.start()
	if Input.is_action_pressed("ui_right"): 
		if $down_cooldown.is_stopped():
			right()
			$down_cooldown.start()
			

func _on_down_timer_timeout():
	if still or rotating: 
		return
	down()
