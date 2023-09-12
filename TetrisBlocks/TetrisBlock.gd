extends Node2D
export var is_I = false
var still =false 
signal still
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func check_colliding(pos:Vector2): 
	$Checker.global_position = pos
#	if $Checker.get_overlapping_bodies().size() > 4: 
#		return true
#	return false 
	for raycast in $Raycasts.get_children():
		if raycast.is_colliding(): 
			return true
	return false

func to_still(): 
	still = true
	emit_signal("still")
	$down_timer.stop()
func down(): 
	var next_pos =Vector2( global_position.x,global_position.y + Global.CELL_SIZE)
	if check_colliding(next_pos): 
		to_still() 
		return 
	var board_next_pos=Global.map_to_board(next_pos).y
	if is_I: 
		board_next_pos = floor(board_next_pos)
	if  board_next_pos > Global.board_rows-1: 
		to_still()
		return
	global_position = next_pos
func left(): 
	var next_pos = Vector2(global_position.x-Global.CELL_SIZE, global_position.y)
	if check_colliding(next_pos): 
		return 
	if Global.map_to_board(next_pos).x < 0: 
		return
	global_position = next_pos
func right(): 
	var next_pos = Vector2(global_position.x+Global.CELL_SIZE,global_position.y)
	if check_colliding(next_pos): 
		return
	print(Global.map_to_board(next_pos).x )
	if Global.map_to_board(next_pos).x > Global.board_cols - 1: 
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
