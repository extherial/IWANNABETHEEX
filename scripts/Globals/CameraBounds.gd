extends Node
class_name Camera_Bounds

var left_bound: float
var right_bound: float
var top_bound: float
var bottom_bound: float
var cam_position: Vector2

func set_bounds(left: float, right: float, bottom: float, top: float):
	left_bound = left
	right_bound = right
	top_bound = top
	bottom_bound = bottom

func set_cam_position(cam_pos: Vector2):
	cam_position = cam_pos

func is_in_bounds(node: Node2D):
	# DEBUG LINE: 
	#print(
		#"node left:   ", "xpos ",node.position.x,  " > ", left_bound, " ", (node.position.x > left_bound),
		#"\nnode right:  ", "xpos ",node.position.x,  " < ", right_bound, " ", (node.position.x < right_bound),
		#"\nnode top:    ", "ypos ",node.position.y,  " > ", top_bound, " ", (node.position.y > top_bound),
		#"\nnode bottom: ", "ypos ",node.position.y,  " < ", bottom_bound, " ", (node.position.y < bottom_bound)
		#)
	if(node.position.x > left_bound
	&& node.position.x < right_bound
	&& node.position.y > top_bound
	&& node.position.y < bottom_bound):
		return true

func get_left_bound():
	return left_bound
func get_right_bound():
	return right_bound
func get_top_bound():
	return top_bound
func get_bottom_bound():
	return bottom_bound
func get_cam_position():
	return cam_position
