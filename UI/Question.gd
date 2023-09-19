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

func line_break(inp_str:String,max_size): 
	var interval = max_size
	if inp_str.length() > interval: 
		var output_str = ""
		for word in inp_str:
			output_str+=word
			if output_str.length() % interval == 0: 
				output_str+="\n" 
		return output_str
	return inp_str

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
			option_node.text=line_break(option,option_node.text.length())
			option_node.visible =true 




func _on_1_pressed():
	if correct == 1: 
		Global.emit_signal("correct_answer")
	else: 
		Global.emit_signal("wrong_answer")

	visible = false


func _on_3_pressed():
	if correct == 3: 
		Global.emit_signal("correct_answer")
	else: 
		Global.emit_signal("wrong_answer")

	visible = false
func _on_4_pressed():
	if correct == 4: 
		Global.emit_signal("correct_answer")
	else: 
		Global.emit_signal("wrong_answer")

	visible = false


func _on_2_pressed():
	if correct == 2: 
		Global.emit_signal("correct_answer")
	else: 
		Global.emit_signal("wrong_answer")

	visible = false
