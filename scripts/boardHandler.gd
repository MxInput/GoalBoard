extends Node

func _ready() -> void:
	if (MemberVariables.new_member.completed_goals.size() > 0):
		for completed_goal in MemberVariables.new_member.completed_goals:
			var new_board_drawing = get_child(0).find_child("Current").duplicate();
			get_child(0).add_child(new_board_drawing);
			new_board_drawing.texture = completed_goal.drawn_texture;
			new_board_drawing.visible = true;
			new_board_drawing.completed_goal = completed_goal;
			new_board_drawing.position = completed_goal.saved_pos;
			
func _on_button_button_down() -> void:
	find_child("Container").visible = false;
	
	var menu = get_parent().find_child("Menu", true, false);
	var camera : Camera2D = menu.get_child(0).find_child("Camera2D");
	camera.make_current();
	
	var menu_container = menu.get_child(0);
	menu_container.visible = true;
	
	var canvas_layer = menu_container.find_child("CanvasLayer");
	canvas_layer.visible = true;
	
	for control_obj in canvas_layer.get_children():
		if (control_obj.name != "Background"):
			control_obj.visible = false;
		
		if (control_obj.name != "DrawingTab" && control_obj.name != "Warning"):
			control_obj.visible = true;
