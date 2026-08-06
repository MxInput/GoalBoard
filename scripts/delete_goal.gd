extends TextureButton

var unfinished_goal : UnfinishedGoal;

signal delete_goal(selected_goal);

func _ready() -> void:
	var goal_creation = get_node("/root/Menu/Container/GoalCreation");

	if (goal_creation != null):
		delete_goal.connect(goal_creation.delete_goal);
		
func _on_button_down() -> void:
	delete_goal.emit(unfinished_goal);
	
	get_parent().queue_free();
