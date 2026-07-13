class_name Member
extends Resource

@export var completed_goals : Array;
@export var unfinished_goals : Array;

func _init(_completed_goals : Array, _unfinished_goals : Array) -> void:
	completed_goals = _completed_goals;
	unfinished_goals = _unfinished_goals;
