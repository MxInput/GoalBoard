extends Node

@onready var tree = get_tree();
var menu;

var background_manager : Node;

var menu_container : Node2D;
var menu_canvas : CanvasLayer;
var menu_background : TextureRect;
var menu_create_button : TextureButton;

var goal_container : ScrollContainer;

var goal_board : Node;

@export var title : RichTextLabel;
@export var background : ColorRect;
@export var return_button : TextureButton;

var settings : Node;

func _ready() -> void:
	var background = MemberVariables.new_member.current_background;

	menu = tree.root.find_child("Menu", true, false);
	
	settings = tree.root.find_child("Settings", true, false);
	
	background_manager = tree.root.find_child("BackgroundManager", true, false);
	
	menu_container = tree.root.find_child("Container", true, false);
	menu_canvas = menu_container.find_child("CanvasLayer", true, false);
	goal_container = menu_canvas.find_child("ScrollContainer", true, false);
	
	if (goal_board == null):
		goal_board = tree.root.find_child("Board", true, false);
					
func choose_background(bg) -> void:
	MemberVariables.new_member.current_background = bg;
	
	background_manager.change_background(bg);
	
	for found_goal in goal_container.get_child(0).get_children():
		if (found_goal.name != "Space"):
			found_goal.texture = bg.goal_texture;
			
			found_goal.find_child("Identifier").set("theme_override_colors/font_color", bg.color4);
			found_goal.find_child("Date").set("theme_override_colors/font_color", bg.color3);
			
			found_goal.find_child("Complete").texture_normal = bg.button_texture;
			found_goal.find_child("Complete").get_child(0).set("theme_override_colors/font_color", bg.color5);
	
			found_goal.find_child("Delete").texture_normal = bg.button_texture;
			found_goal.find_child("Delete").get_child(0).set("theme_override_colors/font_color", bg.color5);
			
	if (goal_board != null):
		goal_board.change_board_colors(bg);

	if (settings != null):
		settings.fit_to_background(bg);
		
	MemberVariables.write_save();
	
func _on_return_button_down() -> void:
	find_child("Container").visible = false;

	var camera : Camera2D = menu.get_child(0).find_child("Camera2D");
	camera.make_current();
	
	menu_container.visible = true;
	
	menu_canvas.visible = true;
