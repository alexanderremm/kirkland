extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2()
const WALK_SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	velocity = Vector2()
	$body.play()
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		# adjust animation/head
		$body.animation = 'right_left'
		$body.flip_h = true
		$head.frame = 3
	if Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
		# adjust animation/head
		$body.animation = 'right_left'
		$body.flip_h = false
		$head.frame = 2
	if Input.is_action_pressed("ui_up"):
		velocity.y = -WALK_SPEED
		# adjust animation/head
		$body.animation = 'front_back'
		$head.frame = 1
	if Input.is_action_pressed("ui_down"):
		velocity.y =  WALK_SPEED
		# adjust animation/head
		$body.animation = 'front_back'
		$head.frame = 0
		
	# Don't play an animation if he is not moving
	if velocity == Vector2(0, 0):
		$body.stop()
		$body.animation = 'front_back'
		$body.frame = 2
		$head.frame = 0
	
	move_and_slide(velocity, Vector2(0, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
