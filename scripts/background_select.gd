extends TextureRect

@export var background : Background;

var background_menu;

signal change_background(bg)

func _ready() -> void:
	background_menu = get_parent().get_parent().get_parent().get_parent();
	change_background.connect(background_menu.choose_background)
	
func _on_enable_button_down() -> void:
	change_background.emit(background);
