extends TextureRect

var completed_goal : CompletedGoal;
var holding = true;
var hovering = false;

@export var popup : TextureRect;

func _input(event: InputEvent) -> void:
	if event.is_action("left_click"):
		if (holding):
			holding = false;
		else:
			holding = true;

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position();
	
	if (holding && hovering):
		position = mouse_pos - Vector2(size.x / 2, size.y/2);

func _on_mouse_entered() -> void:
	hovering = true;
	
	popup.find_child("DateCreated")
	popup.find_child("DateCompleted")
	popup.find_child("Identifier")
	popup.find_child("DateCreated")

func _on_mouse_exited() -> void:
	hovering = false;
