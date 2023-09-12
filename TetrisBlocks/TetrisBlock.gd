extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func check_colliding(pos:Vector2): 
	$Checker.global_position = pos
	if $Checker.get_overlapping_bodies().size() > 0: 
		return true 
	return false

func down(): 
	var next_pos =Vector2( global_position.x,global_position.y + Global.CELL_SIZE)
	if !check_colliding(next_pos): 
		global_position = next_pos
func left(): 
	var next_pos = Vector2(global_position.x-Global.CELL_SIZE, global_position.y)
	if !check_colliding(next_pos): 
		global_position = next_pos
	
func right(): 
	var next_pos = Vector2(global_position.x+Global.CELL_SIZE,global_position.y)
	if !check_colliding(next_pos): 
		global_position = next_pos

func rotate_block(): 
	rotate(deg2rad(90))
func instant_down(): 
	pass
func _physics_process(delta):
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
