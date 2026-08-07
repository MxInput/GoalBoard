class_name Member
extends Resource

enum DateOrders {
	MONTH_FIRST,
	DAY_FIRST,
	YEAR_FIRST,
}

@export var completed_goals : Array;
@export var unfinished_goals : Array;
@export var month_order : DateOrders;
@export var is_12_hr : bool;

@export var current_background : Background;
