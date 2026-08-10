extends Node

@export var canvas_layer : CanvasLayer;

@export var backgrond_template : PackedScene;
var created_background;

@onready var tree = get_tree();

@export var container : Node2D;

var background_list := Background_List.new();

@export var background_select_template : PackedScene;
		
@export var background : TextureRect;
@export var clock : RichTextLabel;

@export var limit_teller1 : Label;
@export var limit_teller2 : Label;

@export var title1 : RichTextLabel;
@export var title2 : RichTextLabel;

@export var backgrounds_button : TextureButton;
@export var settings_button : TextureButton;
@export var board_button : TextureButton;

@export var create_button : TextureButton;

func _ready() -> void:
	var found_bg = MemberVariables.new_member.current_background;
	change_background(found_bg)

func change_background(found_bg) -> void:
	background.texture = found_bg.background_texture;
	clock.set("theme_override_colors/default_color", found_bg.color7); 
		
	limit_teller1.set("theme_override_colors/font_color", found_bg.color7); 
	limit_teller2.set("theme_override_colors/font_color", found_bg.color7); 
	
	title1.set("theme_override_colors/default_color", found_bg.color6); 
	title2.set("theme_override_colors/default_color", found_bg.color6); 
	
	create_button.texture_normal = found_bg.dark_button_texture;
	
	board_button.texture_normal = found_bg.dark_small_button_texture;
	settings_button.texture_normal = found_bg.dark_small_button_texture;
	backgrounds_button.texture_normal = found_bg.dark_small_button_texture;
	
func _on_backgrounds_button_down() -> void:
	container.visible = false;
	canvas_layer.visible = false;
	
	if (created_background == null):
		created_background = backgrond_template.instantiate();
		tree.root.add_child(created_background);
		
		for current_background in background_list.backgrounds:
			var v_box_container = created_background.find_child("Container").find_child("ScrollContainer").find_child("VBoxContainer");
			
			var new_background_select = background_select_template.instantiate();
			v_box_container.add_child(new_background_select);
			
			var name_display = new_background_select.find_child("Name");
			var image_display = new_background_select.find_child("Background");
			var button_display = new_background_select.find_child("ButtonShow");
			var small_button_display = new_background_select.find_child("SmButtonShow");
			var goal_display = new_background_select.find_child("GoalShow");
			
			new_background_select.background = current_background;
			
			name_display.text = current_background.identifier;
			image_display.texture = current_background.background_texture;
			button_display.texture = current_background.button_texture;
			small_button_display.texture = current_background.small_button_texture;
			goal_display.texture = current_background.goal_texture;
	else:
		created_background.get_child(1).visible = true;
		
	created_background.find_child("Camera2D").make_current();
