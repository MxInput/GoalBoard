extends Node

@export var canvas_layer : CanvasLayer;

@export var settings_template : PackedScene;
var created_settings;

@onready var tree = get_tree();

@export var container : Node2D;

func _on_settings_button_down() -> void:
	container.visible = false;
	canvas_layer.visible = false;
	
	if (created_settings == null):
		created_settings = settings_template.instantiate();
		tree.root.add_child(created_settings);
	else:
		created_settings.get_child(1).visible = true;
		
	created_settings.find_child("Camera2D").make_current();
