extends KinematicBody2D


const GRAVITY = 600
const WALK_SPEED = 250
const JUMP_FORCE = 300

const BULLET = preload("res://KilltheMonster/Scene/Bullet.tscn")

var velocity = Vector2()
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	var bullet = BULLET.instance()
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		#bullet.velocity.x = -BULLET_SPEED*delta
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
			
	elif Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	else:
		$AnimatedSprite.animation = "idle"
		# velocity.x = 0
		# smoothen the stop
		velocity.x = lerp(velocity.x, 0, 0.1)
		#bullet.velocity.x = lerp(bullet.velocity.x, 0, 0.1)
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -JUMP_FORCE
	 
	if Input.is_action_just_pressed("ui_focus_next"):
		if sign($Position2D.position.x) == 1:
			bullet.set_bullet_direction(1)
		else:
			bullet.set_bullet_direction(-1)
		
		get_parent().add_child(bullet)
		bullet.position = $Position2D.global_position
		
	velocity = move_and_slide(velocity, Vector2.UP)
	#bullet.velocity = move_and_slide(velocity, Vector2.UP)	
	
	# prevent player going out of screen
	position.x = clamp(position.x, 0, 3775)
	#position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	$AnimatedSprite.play()

	if velocity.x > 0 || velocity.x < 0:
		print("running in")
		$AnimatedSprite.animation = "running"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0

	elif velocity.y > 0 || velocity.y < 0:
		print("up in")
		$AnimatedSprite.animation = "up"
	elif velocity.x == 0 && velocity.y == 0:
		$AnimatedSprite.animation = "idle"
		#$AnimatedSprite.flip_v = velocity.y > 0

	#pass # Replace with function body.
