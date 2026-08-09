extends Node

@onready var tree = get_tree();

@export var container : Control;
@export var liner : ColorRect;
@export var background : ColorRect;
@export var popup : TextureRect;

func _ready() -> void:
	var backgrounds = tree.root.find_child("Backgrounds", true, false);
	if (backgrounds != null):
		backgrounds.goal_board = self;
		
	change_board_colors(MemberVariables.new_member.current_background);
		
	if (MemberVariables.new_member.completed_goals.size() > 0):
		for completed_goal in MemberVariables.new_member.completed_goals:
			var new_board_drawing = get_child(0).find_child("Current").duplicate();
			get_child(0).add_child(new_board_drawing);
			new_board_drawing.texture = completed_goal.drawn_texture;
			new_board_drawing.visible = true;
			new_board_drawing.completed_goal = completed_goal;
			new_board_drawing.position = completed_goal.saved_pos;
		
func change_board_colors(bg) -> void:
	liner.color = bg.color1;
	background.color = bg.color2;
	popup.texture = bg.goal_texture;
	popup.find_child("Delete", true, false).texture_normal = bg.small_button_texture;
	popup.find_child("Delete", true, false).get_child(0).set("theme_override_colors/font_color", bg.color5);
	popup.find_child("Identifier", true, false).set("theme_override_colors/font_color", bg.color4);
	popup.find_child("DateCreated", true, false).set("theme_override_colors/font_color", bg.color3);
	popup.find_child("DateCompleted", true, false).set("theme_override_colors/font_color", bg.color3);
		
func _on_button_button_down() -> void:
	container.visible = false;
	
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
