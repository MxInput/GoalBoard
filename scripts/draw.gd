extends TextureRect

@export var drawable_texture : DrawableTexture2D;
var texture_size : Vector2i = Vector2i(512, 512);

@export var source_img : Texture2D;

@export var canvas_layer : CanvasLayer;

@export var camera : Camera2D;

var current_goal = null;

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
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8);
	
	get_parent().visible = true;
	current_goal = unfinished_goal;
	print(unfinished_goal)
	
	disappear_goal_menu();

func _on_clear_button_down() -> void:
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8);

func _on_finish_button_down() -> void:
	var container = get_node("/root/Menu/Container");
	container.visible = false;
	canvas_layer.visible = false;
	
	if (board == null):
		board = preload("res://nodes/board.tscn").instantiate();
		get_tree().root.add_child(board);
	else:
		board.get_child(0).visible = true;
		
	board.find_child("Camera2D").make_current();
		
	var new_board_drawing = board.find_child("Current").duplicate();
	board.get_child(0).add_child(new_board_drawing);
	new_board_drawing.texture = ImageTexture.create_from_image(drawable_texture.get_image());
	new_board_drawing.visible = true;
	var new_completed_goal := CompletedGoal.new();
	
	new_completed_goal.identifier = current_goal.identifier;
	new_completed_goal.description = current_goal.description;
	new_completed_goal.date_created = current_goal.date;
	new_completed_goal.date_completed = Time.get_datetime_dict_from_system();
	new_completed_goal.drawn_texture = ImageTexture.create_from_image(drawable_texture.get_image());
	new_completed_goal.saved_pos = Vector2(0,0);
	
	new_board_drawing.completed_goal = new_completed_goal;
	
	MemberVariables.new_member.unfinished_goals.remove_at(MemberVariables.new_member.unfinished_goals.find(current_goal));
	MemberVariables.new_member.completed_goals.push_back(new_completed_goal);
	
	MemberVariables.write_save();
	
	drawable_texture.setup(texture_size.x, texture_size.y, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8);

func _on_board_button_down() -> void:
	var container = get_node("/root/Menu/Container");
	container.visible = false;
	canvas_layer.visible = false;
	
	if (board == null):
		board = preload("res://nodes/board.tscn").instantiate();
		get_tree().root.add_child(board);
	else:
		board.get_child(0).visible = true;
		
	board.find_child("Camera2D").make_current();
