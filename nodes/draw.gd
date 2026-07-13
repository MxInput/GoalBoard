extends TextureRect

@export var drawable_texture : DrawableTexture2D;
var texture_size : Vector2i = Vector2i(512, 512);

@export var source_img : Texture2D;

@export var canvas_layer : CanvasLayer;

func disappear_goal_menu() -> void:
	for control_obj in canvas_layer.get_children():
		if (control_obj.name != "Background" && control_obj.name != "DrawingTab"):
			control_obj.visible = false;

func _ready() -> void:
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8, Color.WHITE)

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var local_pos = get_local_mouse_position()
		
		drawable_texture.blit_rect(Rect2i(local_pos.x, local_pos.y, 8, 8), source_img, Color.RED)

func start_drawing(unfinished_goal : UnfinishedGoal) -> void:
	get_parent().visible = true;
	
	disappear_goal_menu();
