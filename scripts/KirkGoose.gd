extends KinematicBody2D


#Jump 
export var fall_gravity_scale := 150.0
export var low_jump_gravity_scale := 200.0
export var jump_power := 1000.0
var jump_released = false
var has_flapped = false

#Physics
var velocity = Vector2()
var earth_gravity = 9.807 # m/s^2
export var gravity_scale := 100.0
var on_floor = false

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_released("ui_jump"):
		jump_released = true

	#Applying gravity to player
	velocity += Vector2.DOWN * earth_gravity * gravity_scale * delta

	#Jump Physics
	if velocity.y > 0: #Player is falling
		#Falling action is faster than jumping action | Like in mario
		#On falling we apply a second gravity to the player
		#We apply ((gravity_scale + fall_gravity_scale) * earth_gravity) gravity on the player
		velocity += Vector2.DOWN * earth_gravity * fall_gravity_scale * delta 

	elif velocity.y < 0 && jump_released: #Player is jumping 
		#Jump Height depends on how long you will hold key
		#If we release the jump before reaching the max height 
		#We apply ((gravity_scale + low_jump_gravity_scale) * earth_gravity) gravity on the player
		#It results in a lower jump
		velocity += Vector2.DOWN * earth_gravity * low_jump_gravity_scale * delta

	if on_floor:
		if Input.is_action_pressed("ui_jump"): 
			velocity = Vector2.UP * jump_power #Normal Jump action
			jump_released = false
			$AnimatedSprite.animation = 'jumping'
			
			if !has_flapped:
				has_flapped = true
				$WingFlap.play()

	velocity = move_and_slide(velocity, Vector2.UP) 

	if is_on_floor(): 
		on_floor = true
		$AnimatedSprite.animation = 'walking'
		has_flapped = false
	else: 
		on_floor = false
