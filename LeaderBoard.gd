extends Control

func clear_leader_board(): 
	for child in $VBoxContainer.get_children():
		if !(child is Label):
			if child.visible ==true:
				$VBoxContainer.remove_child(child)
			
			
		
func add_rank(rank,score): 
	var newhbox = $VBoxContainer/HBoxContainer.duplicate()
	newhbox.get_node("Rank").text = str(rank)+"."
	newhbox.get_node("Score").text = str(score)
	$VBoxContainer.add_child(newhbox)
	newhbox.visible=true
