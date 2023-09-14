extends Node2D
var still =false
func down(): 
	var next_pos =Vector2( global_position.x,global_position.y + Global.CELL_SIZE)
	var addition_pos = Vector2(0,Global.CELL_SIZE)
	if Global.check_tile_colliding($BlockTiles,addition_pos): 
		to_still() 
		return 
	global_position = next_pos
func to_still(): 
	still = true
	$down_timer.stop()
	Global.emit_signal("still",$BlockTiles)
func _physics_process(delta):
	if still: 
		return
func _on_down_timer_timeout():
	if still: 
		return
	down()
