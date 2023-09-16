extends Control

signal correct_answer 
signal wrong_answer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var grid = $VBoxContainer/GridContainer
onready var explanation = $VBoxContainer/Explanation
onready var question = $VBoxContainer/Question
var correct: int



func load_questions(): 
	var data = QuestionData.data[0]
	question.text = data["question"]
	explanation.text = data["explanation"]
	correct = data["correct"]
	
	for opt in grid.get_children(): 
		opt.visible = false

	for i in range(1,5): 
		var idx = str(i)
		var option = data.get(idx)
		if option: 
			var option_node = grid.get_node(idx) 
			option_node.visible =true 




func _on_1_pressed():
	if correct == 1: 
		emit_signal("correct_answer")
	else: 
		emit_signal("wrong_answer")


func _on_2_toggled(button_pressed):
	if correct == 2: 
		emit_signal("correct_answer")
	else: 
		emit_signal("wrong_answer")

func _on_3_pressed():
	if correct == 3: 
		emit_signal("correct_answer")
	else: 
		emit_signal("wrong_answer")

func _on_4_pressed():
	if correct == 4: 
		emit_signal("correct_answer")
	else: 
		emit_signal("wrong_answer")
