extends CanvasLayer

var game = null
onready var scorepoint = $Control/TextureRect/Score
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _initialize(g): 
	game = g 

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("scored",self,"_on_scored")
func _on_scored(add_up): 
	var score = int(scorepoint.text)+add_up
	scorepoint.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	
	pass # Replace with function body.
