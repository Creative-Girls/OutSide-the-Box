extends KinematicBody2D


export var speed = 200

export (PackedScene) var Bullet

var velocity = Vector2.ZERO


func get_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		#forward
		velocity += transform.x * speed
	if Input.is_action_pressed("ui_down"):
		#forward
		velocity -= transform.x * speed

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		shoot()

func _physics_process(delta):
	
	#turn toward mouse
	look_at(get_global_mouse_position())
	
	#moves the player
	get_input()
	velocity = move_and_slide(velocity)


func shoot():
	# create bullet node
	var bullet = Bullet.instance()
	
	# add it to the scene tree (World)
	$"/root/World".add_child(bullet)
	
	# move the bullet to the muzzle of the gun
	bullet.transform = $Muzzle.global_transform
	
	
	
	
	
	
	
