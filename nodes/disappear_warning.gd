extends Label

var max_time := 2.0;
var current_time := 0.0;

func _process(delta: float) -> void:
	if (visible):
		current_time += delta;
		
		if (current_time >= max_time):
			visible = false;
	else:
		current_time = 0.0;
		
