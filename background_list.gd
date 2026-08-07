class_name Background_List
extends Resource

@export var backgrounds : Array;

func _init() -> void:
	backgrounds.push_back(Background.new("White", load("res://images/backgrounds/white_stuff/white_background.png"), load("res://images/backgrounds/white_stuff/white_button.png"), load("res://images/backgrounds/white_stuff/white_sm_button.png"), load("res://images/backgrounds/white_stuff/white_goal.png")));
	backgrounds.push_back(Background.new("Black", load("res://images/backgrounds/dark_stuff/dark_background.png"), load("res://images/backgrounds/dark_stuff/dark_button.png"), load("res://images/backgrounds/dark_stuff/small_dark_button.png"), load("res://images/backgrounds/dark_stuff/goal_dark.png")));
	backgrounds.push_back(Background.new("Bows", load("res://images/backgrounds/pink_stuff/bow_bg.png"), load("res://images/backgrounds/pink_stuff/bow_button.png"), load("res://images/backgrounds/pink_stuff/small_bow_button.png"), load("res://images/backgrounds/pink_stuff/goal_pink.png")));
	backgrounds.push_back(Background.new("Sunflower", load("res://images/backgrounds/sun_stuff/sunflower_bg.png"), load("res://images/backgrounds/sun_stuff/sun_button.png"), load("res://images/backgrounds/sun_stuff/small_sun_button.png"), load("res://images/backgrounds/sun_stuff/goal_sunflower.png")));
	
