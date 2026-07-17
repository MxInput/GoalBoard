extends Node

@export var desc_box : TextEdit;
@export var desc_count : Label;
var current_text := "";
var cursor_line := 0;
var cursor_col := 0;

var max_text_length := 300;

@export var create_button : TextureButton;

@export var identifier_box : LineEdit;
@export var identifier_count : Label;

@export var v_box : VBoxContainer;
@export var temp_goal : PackedScene;

@export var warning : Label;

func _ready() -> void:
	if (MemberVariables.new_member.unfinished_goals.size() > 0):
		for unfinished_goal in MemberVariables.new_member.unfinished_goals:
			var new_goal := temp_goal.instantiate();
			v_box.add_child(new_goal);
			v_box.move_child(v_box.find_child("Space"), -1);
			new_goal.find_child("Identifier").text = unfinished_goal.identifier;
			new_goal.find_child("Description").get_child(0).text = unfinished_goal.description;
			var found_date = Time.get_date_dict_from_system();
			new_goal.find_child("Date").text = "Created: " + str(found_date["month"]) + "/" + str(found_date["day"]) + "/" + str(found_date["year"]);
			new_goal.find_child("Complete").unfinished_goal = unfinished_goal;
			new_goal.find_child("Delete").unfinished_goal = unfinished_goal;
		
func _on_text_edit_text_changed() -> void:
	var new_text := desc_box.text;
	
	if (new_text.length() > max_text_length):
		desc_box.text = current_text;
		
		desc_box.set_caret_column(cursor_col);
		desc_box.set_caret_line(cursor_line);
	
	current_text = desc_box.text;
	cursor_col = desc_box.get_caret_column();
	cursor_line = desc_box.get_caret_line();

	desc_count.text = str(desc_box.text.length()) + "/300"

func _on_create_button_down() -> void:
	if (desc_box.text.length() > 0 && identifier_box.text.length() > 0):
		var desc_string = desc_box.text;
		var identifier_string = identifier_box.text;
		
		desc_box.text = "";
		desc_count.text = "0/300";
		
		identifier_box.text = "";
		identifier_count.text = "0/300";
		
		var new_goal := temp_goal.instantiate();
		v_box.add_child(new_goal);
		v_box.move_child(v_box.find_child("Space"), -1);
		new_goal.find_child("Identifier").text = identifier_string;
		new_goal.find_child("Description").get_child(0).text = desc_string;
		var found_date = Time.get_date_dict_from_system();
		new_goal.find_child("Date").text = "Created: " + str(found_date["month"]) + "/" + str(found_date["day"]) + "/" + str(found_date["year"]);
		
		var goal_entry = UnfinishedGoal.new();
		goal_entry.identifier = identifier_string;
		goal_entry.description = desc_string;
		goal_entry.date = found_date;
		
		new_goal.find_child("Complete").unfinished_goal = goal_entry;
		new_goal.find_child("Delete").unfinished_goal = goal_entry;
		
		MemberVariables.new_member.unfinished_goals.push_back(goal_entry);
		MemberVariables.write_save();
	else:
		warning.visible = true;

func _on_identifier_text_changed(_new_text: String) -> void:
	identifier_count.text = str(identifier_box.text.length()) + "/" + str(identifier_box.max_length);

func delete_goal(selected_goal : UnfinishedGoal) -> void:
	MemberVariables.new_member.unfinished_goals.remove_at(MemberVariables.new_member.unfinished_goals.find(selected_goal));
	MemberVariables.write_save();
