extends Label

var original_y : float;
var jump_height := 5.0;

func _ready() -> void:
	original_y = position.y;
	
func jump() -> void:
	position.y = original_y - jump_height;
	
func _process(_delta: float) -> void:
	if (position.y < original_y):
		position.y += 0.5;
