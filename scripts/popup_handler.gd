extends TextureRect

var current_image;
var saved_image;
@export var hovering := false;

func _process(_delta: float) -> void:
	var upper_limit = global_position.y;
	var lower_limit = global_position.y + size.y;
	var left_limit = global_position.x;
	var right_limit = global_position.x + size.x;
	
	var mouse_pos := get_global_mouse_position();
	
	if mouse_pos.y >= upper_limit && mouse_pos.y <= lower_limit:
		if mouse_pos.x >= left_limit && mouse_pos.x <= right_limit:
			hovering = true;
		else:
			if (current_image == null):
				visible = false;
			hovering = false;
	else:
		if (current_image == null):
			visible = false;
		hovering = false;

func _on_delete_button_down() -> void:
	if (saved_image != null):
		visible = false;
		
		MemberVariables.new_member.completed_goals.remove_at(MemberVariables.new_member.completed_goals.find(saved_image.completed_goal));
		saved_image.queue_free();
		MemberVariables.write_save();
