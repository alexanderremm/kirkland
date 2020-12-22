extends KinematicBody2D


# Declare member variables here. Examples:
var velocity = Vector2()
const WALK_SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
	if Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
	if Input.is_action_pressed("ui_up"):
		velocity.y = -WALK_SPEED
	if Input.is_action_pressed("ui_down"):
		velocity.y =  WALK_SPEED
	move_and_slide(velocity, Vector2(0, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
