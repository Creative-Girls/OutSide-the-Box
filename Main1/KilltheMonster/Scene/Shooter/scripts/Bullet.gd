extends Area2D

var speed = 750

func _ready():
	randomize()
	
func _physics_process(delta):
	# move the bullet
	position += transform.x * speed * delta

 
func _on_Bullet_body_entered(body):
	print("inin")
	if body.is_in_group("shootable"):
		body.hit(rand_range(0.1, 4.0))
	queue_free()
	


func _on_VisibilityNotifier2D_screen_exited():
	print("Bullet out of screen")
	queue_free()
