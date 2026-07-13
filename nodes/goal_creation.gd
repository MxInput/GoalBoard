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
	if (desc_box.text.length() > 0):
		var desc_string = desc_box.text;
		var identifier_string = identifier_box.text;
		
		desc_box.text = "";
		desc_count.text = "0/300";
		
		identifier_box.text = "";
		identifier_count.text = "0/300";
		
		var new_goal := temp_goal.instantiate();
		v_box.add_child(new_goal);
		new_goal.find_child("Identifier").text = identifier_string;
		new_goal.find_child("Description").get_child(0).text = desc_string;
		var found_date = Time.get_date_dict_from_system();
		new_goal.find_child("Date").text = "Created: " + str(found_date["month"]) + "/" + str(found_date["day"]) + "/" + str(found_date["year"]);
		
		var goal_entry = UnfinishedGoal.new(identifier_string, desc_string, found_date);
		new_goal.find_child("Complete").unfinished_good = goal_entry;
			
		MemberVariables.new_member.unfinished_goals.push_back(goal_entry);
	else:
		print("enter your goals")


func _on_identifier_text_changed(_new_text: String) -> void:
	identifier_count.text = str(identifier_box.text.length()) + "/" + str(identifier_box.max_length);
