extends Node2D
@export var sign_pages: Array[String] = []
@export var scroll_speed := 1.0
var in_sign_radius = false
@onready var sign_label = $Textbox/MarginContainer/MarginContainer/HBoxContainer/sign_label
@onready var indicator_label = $Interaction_Area/Indicator_Text
@onready var textbox = $Textbox

var text_is_scrolling = false
var skip_text = false
var current_page_text = ""
var text_page = 0
var max_text_page = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	indicator_label.hide()
	textbox.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("interact") && in_sign_radius):
		if(text_is_scrolling):
			skip_text = true
		else:
			next_page()
	pass

func next_page():
	if(text_page < len(sign_pages) && (skip_text || text_is_scrolling == false)):
		current_page_text = sign_pages.get(text_page)
		text_page += 1
		skip_text = false
		display_sign_text()
	else:
		skip_text = false
		indicator_label.hide()
		textbox.hide()
		
	
func display_sign_text():
	$Textbox/MarginContainer/MarginContainer/HBoxContainer/more_text.hide()
	text_is_scrolling = true
	sign_label.text = ""
	textbox.show()
	for i in len(current_page_text): 
		if(skip_text):
			sign_label.text = current_page_text
			break
		sign_label.text = 	current_page_text.substr(0,i + 1)
		await get_tree().create_timer(scroll_speed / 40).timeout
	text_is_scrolling = false
	$Textbox/MarginContainer/MarginContainer/HBoxContainer/more_text.show()
	pass

func _on_interaction_area_area_entered(area) -> void:
	if(area.get_parent() is Player):
		in_sign_radius = true
		indicator_label.show()
	pass # Replace with function body.


func _on_interaction_area_area_exited(area) -> void:
	if(area.get_parent() is Player):
		indicator_label.hide()
		textbox.hide()
		in_sign_radius = false
		skip_text = false
		sign_label.text = ""
		text_page = 0
	pass # Replace with function body.
