extends TextureRect

var completed_goal : CompletedGoal;
var holding = true;
var hovering = false;

var showing_image = false;

@export var popup : TextureRect;

func _input(event: InputEvent) -> void:
	if event.is_action("left_click"):
		if (holding):
			holding = false;
		else:
			if (!popup.hovering):
				holding = true;

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position();
	
	if (holding && hovering):
		position = mouse_pos - Vector2(size.x / 2, size.y/2);
		
	if (holding):
		popup.visible = false;
	elif (showing_image):
		popup.visible = true;
		
		popup.position = self.position - Vector2(0, size.y/2);

func _on_mouse_entered() -> void:
	hovering = true;
	
	if (hovering && !holding):
		popup.current_image = self;
	
		popup.find_child("DateCreated").text = "Created: " + str(completed_goal.date_created["month"]) + "/" + str(completed_goal.date_created["day"]) + "/" + str(completed_goal.date_created["year"]);
		popup.find_child("DateCompleted").text = "Completed: " + str(completed_goal.date_completed["month"]) + "/" + str(completed_goal.date_completed["day"]) + "/" + str(completed_goal.date_completed["year"]);
		popup.find_child("Identifier").text = completed_goal.identifier;
		popup.find_child("Description").get_child(0).text = completed_goal.description;
		
		popup.visible = true;
		
		popup.position = self.position;
		
		showing_image = true;
	
func _on_mouse_exited() -> void:
	hovering = false;
	
	if (popup.current_image == self):
		popup.current_image = null;
		popup.visible = false;
		
		showing_image = false;
