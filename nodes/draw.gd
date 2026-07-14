extends TextureRect

@export var drawable_texture : DrawableTexture2D;
var texture_size : Vector2i = Vector2i(512, 512);

@export var source_img : Texture2D;

@export var canvas_layer : CanvasLayer;

@export var camera : Camera2D;

var completed = false;

var board;

func disappear_goal_menu() -> void:
	for control_obj in canvas_layer.get_children():
		if (control_obj.name != "Background" && control_obj.name != "DrawingTab"):
			control_obj.visible = false;

func _ready() -> void:
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8);

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var local_pos = get_local_mouse_position()
		
		drawable_texture.blit_rect(Rect2i(local_pos.x, local_pos.y, 8, 8), source_img, Color.BLACK)

func start_drawing(unfinished_goal : UnfinishedGoal) -> void:
	get_parent().visible = true;
	
	disappear_goal_menu();

func _on_clear_button_down() -> void:
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8);


func _on_finish_button_down() -> void:
	var container = get_node("/root/Menu/Container");
	container.visible = false;
	canvas_layer.visible = false;
	
	board = preload("res://nodes/board.tscn").instantiate();
	get_tree().root.add_child(board);
	board.find_child("Camera2D").make_current();
	board.find_child("Current").texture = ImageTexture.create_from_image(drawable_texture.get_image());
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8);
