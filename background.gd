class_name Background
extends Resource

@export var identifier : String;

@export var background_texture : Texture2D;
@export var button_texture : Texture2D;
@export var small_button_texture : Texture2D;
@export var goal_texture : Texture2D;

@export var color1 : Color;
@export var color2 : Color;
@export var color3 : Color;
@export var color4 : Color;
@export var color5 : Color;

func _init(_identifier := "", _background_texture := Texture2D.new(), _button_texture := Texture2D.new(), _small_button_texture := Texture2D.new(), _goal_texture := Texture2D.new(), _color1 := Color.WHITE, _color2 := Color.WHITE, _color3 := Color.WHITE, _color4 := Color.WHITE, _color5 := Color.WHITE) -> void:
	identifier = _identifier;
	
	background_texture = _background_texture;
	button_texture = _button_texture;
	small_button_texture = _small_button_texture;
	goal_texture = _goal_texture;
	
	color1 = _color1;
	color2 = _color2;
	color3 = _color3;
	color4 = _color4;
	color5 = _color5;
