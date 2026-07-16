class_name UnfinishedGoal
extends Resource

@export var identifier : String;
@export var description : String
@export var date : Dictionary

func _init(_identifier : String, _description : String, _date : Dictionary) -> void:
	identifier = _identifier;
	description = _description;
	date = _date;
