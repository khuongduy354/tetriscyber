extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("clear_line",self,"_on_clear_line")
	pass # Replace with function body.

func _on_clear_line(count): 
	var score = 0
	match count: 
		1: score =100 
		2: score =300 
		3: score =500
		4: score =800
	Global.emit_signal("scored",score)
		
