extends TextureRect

var completed_goal : CompletedGoal;
var holding = true;
var hovering = false;

var showing_image = false;

@export var popup : TextureRect;

var finished_move_timer : Timer;

var last_position;

@export var save_handler : Node;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		if (!popup.hovering):
			holding = true;
	elif event.is_action_released("left_click"): 
			holding = false;

func _ready() -> void:
	finished_move_timer = get_child(0);
	
	last_position = position;
	
func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position();
	
	if (holding && hovering):
		position = mouse_pos - Vector2(size.x / 2, size.y/2);
		
		if (last_position != position):
			last_position = position;
			
			if (!save_handler.to_save.is_empty()):
				for image_to_save in save_handler.to_save:
					image_to_save.get_child(0).stop();
					save_handler.to_save.erase(image_to_save);
					
			finished_move_timer.start();	
			save_handler.to_save.push_back(self);
		
	if (holding):
		popup.visible = false;
	elif (showing_image):
		popup.visible = true;
		
		popup.position = self.position - Vector2(size.x/2, size.y/2);

func _on_mouse_entered() -> void:
	hovering = true;
	
	if (hovering && !holding):
		popup.current_image = self;
		popup.saved_image = self;
	
		popup.find_child("DateCreated").text = "Created: " + str(completed_goal.date_created["month"]) + "/" + str(completed_goal.date_created["day"]) + "/" + str(completed_goal.date_created["year"]);
		popup.find_child("DateCompleted").text = "Completed: " + str(completed_goal.date_completed["month"]) + "/" + str(completed_goal.date_completed["day"]) + "/" + str(completed_goal.date_completed["year"]);
		popup.find_child("Identifier").text = completed_goal.identifier;
		popup.find_child("Description").get_child(0).text = completed_goal.description;
		
		popup.visible = true;
		
		popup.position = self.position;
		
		showing_image = true;
	
func _on_mouse_exited() -> void:
	hovering = false;
	
	if (popup.current_image == self && !popup.hovering):
		popup.current_image = null;
		popup.visible = false;
		
		showing_image = false;
	elif (popup.hovering):
		popup.current_image = null;
		
		showing_image = false;
	elif (popup.saved_image == self):
		popup.saved_image = null;

func _on_finish_move_timeout() -> void:
	save_handler.to_save.clear();
	var found_goal_index = MemberVariables.new_member.completed_goals.find(completed_goal);
	var found_goal = MemberVariables.new_member.completed_goals.get(found_goal_index);
	
	found_goal.saved_pos = position;
	
	MemberVariables.write_save();
