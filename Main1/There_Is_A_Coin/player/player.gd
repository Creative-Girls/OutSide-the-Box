extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 180
const GRAVITY = 35 
const JUMPFORCE = -650 #the player jumps this force (ex. if the jumpforce is big, the player jump more high.) 

func _physics_process(delta):
	
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
		
	if not is_on_floor(): #if the player is jumping
		$Sprite.play("jump")
	
	velocity.y = velocity.y + GRAVITY 
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		$Jump.play()
		
	velocity = move_and_slide(velocity, Vector2.UP) #the player can move 
	
	velocity.x = lerp(velocity.x,0,0.2)
	
	var position = get_global_position()
	if position.x > 5820: #if the player is in end of the scene,
		get_tree().change_scene("res://Outro/Main.tscn") #the scene is change to Outro.
		print("GameClear")
	elif position.y >1500: #if the player fall down the platform, 
		#(if position.y>800, the gameover sound is playing so I made the condition more exaggerate.)
		get_tree().change_scene("res://There_Is_A_Coin/world/World.tscn") #the scene is change to the first scene  of the game. 
	elif position.y >800: #if the player fall down the platform, 
		$GameOver.play() #this sound plays
		print("GameOver")



