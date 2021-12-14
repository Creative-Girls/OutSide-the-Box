extends Area2D

const SPEED = 500
var velocity = Vector2()
var direction = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
func set_bullet_direction(dir):
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
	if body.is_in_group("monster"):
		print("kill monster")
		direction = direction*-1
		
	if body.is_in_group("player"):
		print("kill player")
		body.hit()
		queue_free()
		#direction = direction*-1
		#body.hit(rand_range(0.1, 4.0))
		
	#queue_free()
	#pass # Replace with function body.
