extends TextureButton

var unfinished_goal : UnfinishedGoal;

signal activate_draw(selected_go);

func _ready() -> void:
	var canvas_layer = get_node("/root/Menu/Container/CanvasLayer");
	var drawHandler = canvas_layer.find_child("DrawingTab");
	var drawing = drawHandler.find_child("Drawing");
	
	if (drawing != null):
		activate_draw.connect(drawing.start_drawing);
		
func _on_button_down() -> void:
	activate_draw.emit(unfinished_goal);
	
	get_parent().queue_free();
