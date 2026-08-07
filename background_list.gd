class_name Background_List
extends Resource

@export var backgrounds : Array;

func _init() -> void:
	backgrounds.push_back(Background.new("Bows"));
	backgrounds.push_back(Background.new("Sunflower"));
	backgrounds.push_back(Background.new("Bubbles"));
	backgrounds.push_back(Background.new("White"));
	backgrounds.push_back(Background.new("Black"));
