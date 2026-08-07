class_name Background
extends Resource

@export var identifier : String;

@export var background_texture : Texture2D;
@export var button_texture : Texture2D;

func _init(_identifier := "", _background_texture := Texture2D.new(), _button_texture := Texture2D.new()) -> void:
	identifier = _identifier;
	background_texture = _background_texture;
	button_texture = _button_texture;
