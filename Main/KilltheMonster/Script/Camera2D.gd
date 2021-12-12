extends Camera2D
onready var player = get_node("/root/Main/Player")
#This function gets called every frame
func _process (delta):
	if player.position.x > 546:
		position.x = player.position.x
