extends Area2D

class_name Obstacle
onready var _animated_sprite = $AnimatedSprite

func _ready():
	_animated_sprite.play()
