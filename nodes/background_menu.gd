extends Node

@onready var tree = get_tree();
var menu;
var menu_container : Node2D;
var menu_canvas : CanvasLayer;
var menu_background : TextureRect;
var menu_create_button : TextureButton;

func _ready() -> void:
	menu = tree.root.find_child("Menu", true, false);
	menu_container = tree.root.find_child("Container", true, false);
	menu_canvas = menu_container.find_child("CanvasLayer", true, false);
	menu_background = menu_canvas.find_child("Background", true, false);
	menu_create_button = menu_canvas.find_child("Create", true, false);
	
func choose_background(bg) -> void:
	MemberVariables.new_member.current_background = bg;
	
	menu_background.texture = bg.background_texture;
	menu_create_button.texture_normal = bg.button_texture;
	
	MemberVariables.write_save();
	
func _on_return_button_down() -> void:
	find_child("Container").visible = false;

	var camera : Camera2D = menu.get_child(0).find_child("Camera2D");
	camera.make_current();
	
	menu_container.visible = true;
	
	menu_canvas.visible = true;
