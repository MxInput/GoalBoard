extends Camera2D

var pan_dis := 10;

var min_zoom = Vector2(0.675, 0.675);
var max_zoom = Vector2(2.5, 2.5);
var zoom_speed = Vector2(0.3, 0.3);

func _input(event: InputEvent) -> void:
	if (event.is_action("out")):
		if (zoom > min_zoom):
			zoom -= zoom_speed;
	if (event.is_action("in")):
		if (zoom < max_zoom):
			zoom += zoom_speed;	
			
	if event.is_action("up"):
		if position.y - (get_viewport_rect().size.y/2.0) / zoom.y > limit_top:
			position.y -= pan_dis;
	if event.is_action("down"):
		if position.y + (get_viewport_rect().size.y/2.0) / zoom.y < limit_bottom:
			position.y += pan_dis;
	if event.is_action("left"):
		if position.x - (get_viewport_rect().size.x/2.0) / zoom.x > limit_left:
			position.x -= pan_dis ;
	if event.is_action("right"):
		if position.x + (get_viewport_rect().size.x/2.0) / zoom.x < limit_right:
			position.x += pan_dis;
