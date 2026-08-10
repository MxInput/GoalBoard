extends Node

const SAVE_PATH := "user://member.tres"

var new_member : Member;

func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		new_member = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		var backgrounds = Background_List.new().backgrounds;
		
		new_member = Member.new();
		
		new_member.completed_goals = [];
		new_member.unfinished_goals = [];
		
		new_member.month_order = Member.DateOrders.MONTH_FIRST;
		new_member.is_12_hr = true;
		new_member.current_background = backgrounds[0];
		new_member.total_completed_orders = 0;
		
func write_save() -> void:
	var error_code := ResourceSaver.save(new_member, SAVE_PATH)
	if error_code != OK:
		push_error("Failed to save game: " + error_string(error_code))
