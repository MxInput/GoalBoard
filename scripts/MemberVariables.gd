extends Node

const SAVE_PATH := "user://member.tres"

var new_member : Member;

func _ready() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		new_member = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		new_member = Member.new();
		new_member.completed_goals = [];
		new_member.unfinished_goals = [];
		
func write_save() -> void:
	var error_code := ResourceSaver.save(new_member, SAVE_PATH)
	if error_code != OK:
		push_error("Failed to save game: " + error_string(error_code))
