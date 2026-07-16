class_name CompletedGoal
extends Resource

@export var identifier : String;
@export var description : String;

@export var date_created : Dictionary;
@export var date_completed : Dictionary;

@export var drawn_texture : ImageTexture;
@export var saved_pos : Vector2;

func _init(_identifier : String, _description : String, _date_created : Dictionary, _date_completed : Dictionary, _drawn_texture : ImageTexture, _saved_pos : Vector2) -> void:
	identifier = _identifier;
	description = _description;
	
	date_created = _date_created;
	date_completed = _date_completed;
	
	drawn_texture = _drawn_texture;
	saved_pos = _saved_pos;
