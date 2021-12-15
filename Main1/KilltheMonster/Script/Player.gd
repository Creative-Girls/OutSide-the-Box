extends KinematicBody2D


const GRAVITY = 600
const WALK_SPEED = 250
const JUMP_FORCE = 300

const BULLET = preload("res://KilltheMonster/Scene/Bullet.tscn")

var velocity = Vector2()
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("player")
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	var bullet = BULLET.instance()
			
	if Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED
		if sign($Muzzle.position.x) == -1:
			$Muzzle.position.x *= 1
	else:
		$AnimatedSprite.animation = "idle"
		# smoothen the stop
		velocity.x = lerp(velocity.x, 0, 0.1)
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		$Jump.play()
		velocity.y = -JUMP_FORCE
	 
	if Input.is_action_just_pressed("ui_focus_next"):
		if sign($Muzzle.position.x) == 1:
			bullet.set_bullet_direction(1)
		else:
			bullet.set_bullet_direction(-1)
		
		shoot()
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# prevent player going out of screen
	position.x = clamp(position.x, 0, 3775)
	#position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	$AnimatedSprite.play()

	if velocity.x > 0 || velocity.x < 0:
		$AnimatedSprite.animation = "running"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0

	elif velocity.y > 0 || velocity.y < 0:
		$AnimatedSprite.animation = "up"
	elif velocity.x == 0 && velocity.y == 0:
		$AnimatedSprite.animation = "idle"
		#$AnimatedSprite.flip_v = velocity.y > 0

	#When you reach your destination, move on to the next map
	if position.x > 3200:
		print("clear")
		get_tree().change_scene("res://There_is_A_Coin/world/World.tscn")
	#If you fall off a cliff, the game is over	
	elif position.y >596:
		get_tree().change_scene("res://KilltheMonster/Scene/Main.tscn")
	#pass # Replace with function body.
func shoot():
	# create bullet node
	var bullet = BULLET.instance()
	
	# add it to the scene tree (World)
	#$"/root/World".add_child(bullet)
	$"/root/Main".add_child(bullet)
	
	# move the bullet to the muzzle of the gun
	bullet.transform = $Muzzle.global_transform
	
func hit():
	get_tree().change_scene("res://KilltheMonster/Scene/Main.tscn")
	$GameOver.play()
	print("Game Over")
