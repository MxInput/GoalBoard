class_name Background_List
extends Resource

@export var backgrounds : Array;

func _init() -> void:
	backgrounds.push_back(Background.new("White", load("res://images/backgrounds/white_stuff/white_background.png"), load("res://images/backgrounds/white_stuff/white_button.png"), load("res://images/backgrounds/white_stuff/white_sm_button.png"), load("res://images/backgrounds/white_stuff/white_goal.png"), Color.html("#1b2a44"), Color.html("#657b9f"), Color.html("#ffffff"), Color.html("#1b2a44"), Color.html("#ffffff")));
	backgrounds.push_back(Background.new("Black", load("res://images/backgrounds/dark_stuff/dark_background.png"), load("res://images/backgrounds/dark_stuff/dark_button.png"), load("res://images/backgrounds/dark_stuff/small_dark_button.png"), load("res://images/backgrounds/dark_stuff/goal_dark.png"), Color.html("#312c58"), Color.html("#615d83"), Color.html("#ffffff"), Color.html("#312c58"), Color.html("#ffffff")));
	backgrounds.push_back(Background.new("Bows", load("res://images/backgrounds/pink_stuff/bow_bg.png"), load("res://images/backgrounds/pink_stuff/bow_button.png"), load("res://images/backgrounds/pink_stuff/small_bow_button.png"), load("res://images/backgrounds/pink_stuff/goal_pink.png"), Color.html("#f8b8b9"), Color.html("#e86a73"), Color.html("#e86a73"), Color.html("#e86a73"), Color.html("#ffffff")));
	backgrounds.push_back(Background.new("Sunflower", load("res://images/backgrounds/sun_stuff/sunflower_bg.png"), load("res://images/backgrounds/sun_stuff/sun_button.png"), load("res://images/backgrounds/sun_stuff/small_sun_button.png"), load("res://images/backgrounds/sun_stuff/goal_sunflower.png"), Color.html("#ffd541"), Color.html("#5b3138"), Color.html("#5b3138"), Color.html("#5b3138"), Color.html("#5b3138")));
	
