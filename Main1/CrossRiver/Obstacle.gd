extends Area2D

class_name Obstacle
# Gaeun 
# rock is moving
onready var _animated_sprite = $AnimatedSprite

# Gaeun 
# when pressed buttuon -> game over 

func _ready():
	_animated_sprite.play()
