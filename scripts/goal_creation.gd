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

@export var search_box : LineEdit;

@export var v_box : VBoxContainer;
@export var temp_goal : PackedScene;

@export var warning : Label;

var filled := false;

@export var goal_counter : Label;
@export var completed_counter : Label;

func _ready() -> void:
	if (MemberVariables.new_member.unfinished_goals.size() > 0):
		for unfinished_goal in MemberVariables.new_member.unfinished_goals:
			var bg := MemberVariables.new_member.current_background;
			
			var new_goal := temp_goal.instantiate();
			new_goal.texture = bg.goal_texture;
			
			v_box.add_child(new_goal);
			v_box.move_child(v_box.find_child("Space"), -1);
			
			new_goal.find_child("Identifier").text = unfinished_goal.identifier;
			new_goal.find_child("Identifier").set("theme_override_colors/font_color", bg.color4);
			
			new_goal.find_child("Description").get_child(0).text = unfinished_goal.description;
			
			var found_date = unfinished_goal.date;
			new_goal.find_child("Date").text = "Created: " + str(found_date["month"]) + "/" + str(found_date["day"]) + "/" + str(found_date["year"]);
			new_goal.find_child("Date").set("theme_override_colors/font_color", bg.color3);
			
			new_goal.find_child("Complete").unfinished_goal = unfinished_goal;
			new_goal.find_child("Complete").texture_normal = bg.button_texture;
			new_goal.find_child("Complete").get_child(0).set("theme_override_colors/font_color", bg.color5);
			
			new_goal.find_child("Delete").unfinished_goal = unfinished_goal;
			new_goal.find_child("Delete").texture_normal = bg.button_texture;
			new_goal.find_child("Delete").get_child(0).set("theme_override_colors/font_color", bg.color5);
	
	filled = true;
	
	var num_goals = (v_box.get_child_count() - 1);
	
	if (num_goals <= 0):
		goal_counter.visible = false;
	else:
		if (num_goals > 1):
			goal_counter.text = str(num_goals) + " goals in progress.";
		else:
			goal_counter.text = str(num_goals) + " goal in progress.";
	
	var total_completed_orders = MemberVariables.new_member.total_completed_orders;
	if (total_completed_orders <= 0):
		completed_counter.visible = false;
	else:
		if (total_completed_orders > 1):
			completed_counter.text = str(total_completed_orders) + " goals completed (lifetime)";
		else:
			completed_counter.text = str(total_completed_orders) + " goal completed (lifetime)";
		
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
		var bg := MemberVariables.new_member.current_background;
		
		var desc_string = desc_box.text;
		var identifier_string = identifier_box.text;
		
		desc_box.text = "";
		desc_count.text = "0/300";
		
		identifier_box.text = "";
		identifier_count.text = "0/300";
		
		var new_goal := temp_goal.instantiate();
		new_goal.texture = bg.goal_texture;
		
		new_goal.find_child("Identifier").text = identifier_string;
		new_goal.find_child("Identifier").set("theme_override_colors/font_color", bg.color4);
		
		new_goal.find_child("Description").get_child(0).text = desc_string;
		var found_date = Time.get_date_dict_from_system();
		new_goal.find_child("Date").text = "Created: " + str(found_date["month"]) + "/" + str(found_date["day"]) + "/" + str(found_date["year"]);
		new_goal.find_child("Date").set("theme_override_colors/font_color", bg.color3);
		
		var goal_entry = UnfinishedGoal.new();
		goal_entry.identifier = identifier_string;
		goal_entry.description = desc_string;
		goal_entry.date = found_date;
		
		new_goal.find_child("Complete").unfinished_goal = goal_entry;
		new_goal.find_child("Complete").texture_normal = bg.button_texture;
		new_goal.find_child("Complete").get_child(0).set("theme_override_colors/font_color", bg.color5);
			
		new_goal.find_child("Delete").unfinished_goal = goal_entry;
		new_goal.find_child("Delete").texture_normal = bg.button_texture;
		new_goal.find_child("Delete").get_child(0).set("theme_override_colors/font_color", bg.color5);
		
		v_box.add_child(new_goal);
		v_box.move_child(v_box.find_child("Space"), -1);
			
		MemberVariables.new_member.unfinished_goals.push_back(goal_entry);
		MemberVariables.write_save();
	else:
		warning.visible = true;

func _on_identifier_text_changed(_new_text: String) -> void:
	identifier_count.text = str(identifier_box.text.length()) + "/" + str(identifier_box.max_length);

func delete_goal(selected_goal : UnfinishedGoal) -> void:
	MemberVariables.new_member.unfinished_goals.remove_at(MemberVariables.new_member.unfinished_goals.find(selected_goal));
	MemberVariables.write_save();

func _on_erase_all_button_down() -> void:
	delete_all_goals();
	
func delete_all_goals() -> void:
	for found_goal in v_box.get_children():
		if (found_goal.name != "Space"):
			found_goal.queue_free();
	MemberVariables.new_member.unfinished_goals.clear();
	MemberVariables.write_save();

func _on_search_text_changed(_new_text: String) -> void:
	for found_goal in v_box.get_children():
		if (found_goal.name != "Space"):
			if (search_box.text.is_empty()):
				found_goal.visible = true;
			else:
				var identifier_to_check = found_goal.find_child("Complete", true, false).unfinished_goal.identifier;

				if (identifier_to_check.find(search_box.text) != -1):
					found_goal.visible = true;
				else:
					found_goal.visible = false;
			
func _on_v_box_container_child_entered_tree(node: Node) -> void:
	if (filled):
		var identifier_to_check = node.find_child("Complete", true, false).unfinished_goal.identifier;

		if (search_box.text.is_empty()):
			node.visible = true;
		else:
			if (identifier_to_check.find(search_box.text) != -1):
				node.visible = true;
			else:
				node.visible = false;
			
		activate_goal_counter();

func activate_goal_counter() -> void:
	var num_goals = (v_box.get_child_count() - 1);
	
	if (num_goals > 0):
		goal_counter.visible = true;
			
		if (num_goals > 1):
			goal_counter.text = str(num_goals) + " goals in progress.";
		else:
			goal_counter.text = str(num_goals) + " goal in progress.";
	else:
		goal_counter.visible = false;
				
func _on_v_box_container_child_exiting_tree(_node: Node) -> void:
	var num_goals = (v_box.get_child_count() - 2);
	
	if (num_goals <= 0):
		goal_counter.visible = false;
	else:
		if (num_goals > 1):
			goal_counter.text = str(num_goals) + " goals in progress.";
		else:
			goal_counter.text = str(num_goals) + " goal in progress.";

func _process(delta: float) -> void:
	var total_completed_orders = MemberVariables.new_member.total_completed_orders;
	
	if (total_completed_orders > 0):
		if (total_completed_orders > 1):
			completed_counter.text = str(total_completed_orders) + " goals completed (lifetime)";
		else:
			completed_counter.text = str(total_completed_orders) + " goal completed (lifetime)";
