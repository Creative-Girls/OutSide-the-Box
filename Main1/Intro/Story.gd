extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Gaeun 
# when pressed buttuon -> intro
func _on_Story_button_up():
	get_tree().change_scene("res://Intro/Story.tscn")
