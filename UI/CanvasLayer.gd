extends CanvasLayer

var game = null
onready var scorepoint = $Control/TextureRect/Score
onready var question = $QuestionContainer/Question
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _initialize(g): 
	game = g 
	
func pop_question(): 
	question.load_questions()
	question.visible = true
		

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("scored",self,"_on_scored")
func _on_scored(add_up): 
	var score = int(scorepoint.text)+add_up
	scorepoint.text = str(score)
func get_score(): 
	return int(scorepoint.text)
	
func reset_score(): 
	scorepoint.text = "0"
func load_to_leaderboard(): 
	$LeaderBoard.clear_leader_board()
	var sorted_list = Global.score_list 
	print(sorted_list)
	sorted_list.sort() 
	for i in range(sorted_list.size()-1,-1,-1): 
		var score = sorted_list[i]
		$LeaderBoard.add_rank(sorted_list.size()-i,score)
		pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	
	pass # Replace with function body.
