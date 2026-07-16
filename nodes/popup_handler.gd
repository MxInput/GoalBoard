extends TextureRect

var current_image;
@export var hovering := false;
@export var active := false;

func _on_mouse_entered() -> void:
	print("entered")
	hovering = true;
	
func _on_mouse_exited() -> void:
	print("exit")
	hovering = false;
