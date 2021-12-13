extends Area2D

const SPEED = 500
var velocity = Vector2()
var direction = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_bullet_direction(dir):
	print("set_bullet_direction",dir)
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	
	if velocity.x > 0 || velocity.x < 0:
		$Sprite.flip_h = velocity.x < 0

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
# 	Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Bullet_body_entered(body):
	print("aaaaaa")
	print("aaaa",body)
	if body.is_in_group("monster"):
		body.hit()
	queue_free()
	#pass # Replace with function body.
