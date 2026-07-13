extends TextureRect

@export var drawable_texture : DrawableTexture2D;
var texture_size : Vector2i = Vector2i(512, 512);

@export var source_img : Texture2D;

@export var text_box : TextEdit;
@export var text_count : Label;
var current_text := "";
var cursor_line := 0;
var cursor_col := 0;

var max_text_length := 300;

@export var create_button : TextureButton;

func _ready() -> void:
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8, Color.WHITE)

func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var local_pos = get_local_mouse_position()
		
		drawable_texture.blit_rect(Rect2i(local_pos.x, local_pos.y, 8, 8), source_img, Color.RED)


func _on_text_edit_text_changed() -> void:
	var new_text := text_box.text;
	
	if (text_box.text.length() > max_text_length):
		text_box.text = current_text;
		
		text_box.set_caret_column(cursor_col);
		text_box.set_caret_line(cursor_line);
	
	current_text = text_box.text;
	cursor_col = text_box.get_caret_column();
	cursor_line = text_box.get_caret_line();

	text_count.text = str(text_box.text.length()) + "/300"


func _on_create_button_down() -> void:
	if (text_box.text.length() > 0):
		print("saving")
	else:
		print("enter your goals")
