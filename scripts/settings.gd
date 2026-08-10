extends Node

@export var month_first : CheckBox;
@export var day_first : CheckBox;
@export var year_first : CheckBox;

@export var hr_24 : CheckBox;
@export var hr_12 : CheckBox;

@export var background : ColorRect;

@export var title : RichTextLabel;

@export var return_button : TextureButton;

@export var subtitle1 : RichTextLabel;
@export var subtitle2 : RichTextLabel;
@export var subtitle3 : RichTextLabel;
	
func fit_to_background(bg) -> void:
	title.set("theme_override_colors/default_color", bg.color1);
	
	return_button.texture_normal = bg.small_button_texture;
	return_button.get_child(0).set("theme_override_colors/font_color", bg.color5);
	
	background.color = bg.color2;
	
	subtitle1.set("theme_override_colors/default_color", bg.color2);
	subtitle2.set("theme_override_colors/default_color", bg.color2);
	subtitle3.set("theme_override_colors/default_color", bg.color2);
	
func _ready() -> void:
	var found_background = MemberVariables.new_member.current_background;
	print("here")
	fit_to_background(found_background);
	
	var member = MemberVariables.new_member;
	var date_format = member.month_order;
	var is_12_hr = member.is_12_hr;

	match (date_format):
		Member.DateOrders.DAY_FIRST:
			day_first.button_pressed = true;
		Member.DateOrders.MONTH_FIRST:
			month_first.button_pressed = true;
		Member.DateOrders.YEAR_FIRST:
			year_first.button_pressed = true;
			
	if (is_12_hr):
		hr_12.button_pressed = true;
	else:
		hr_24.button_pressed = true;

func _on_return_button_down() -> void:
	find_child("Container").visible = false;
	
	var menu = get_parent().find_child("Menu", true, false);
	var camera : Camera2D = menu.get_child(0).find_child("Camera2D");
	camera.make_current();
	
	var menu_container = menu.get_child(0);
	menu_container.visible = true;
	
	var canvas_layer = menu_container.find_child("CanvasLayer");
	canvas_layer.visible = true;

func _on_month_first_button_down() -> void:
	MemberVariables.new_member.month_order = Member.DateOrders.MONTH_FIRST;
	MemberVariables.write_save();
	
func _on_day_first_button_down() -> void:
	MemberVariables.new_member.month_order = Member.DateOrders.DAY_FIRST;
	MemberVariables.write_save();

func _on_year_first_button_down() -> void:
	MemberVariables.new_member.month_order = Member.DateOrders.YEAR_FIRST;
	MemberVariables.write_save();

func _on_hour_24_button_down() -> void:
	MemberVariables.new_member.is_12_hr = false;
	MemberVariables.write_save();

func _on_hour_12_button_down() -> void:
	MemberVariables.new_member.is_12_hr = true;
	MemberVariables.write_save();
