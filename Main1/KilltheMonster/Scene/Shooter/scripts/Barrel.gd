extends StaticBody2D


var health = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("shootable")


func hit(damage):
	health -= damage
	if health <= 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
