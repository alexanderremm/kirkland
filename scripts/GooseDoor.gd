extends AnimatedSprite

# Bool for if kirk is in the door's trigger area
var canPlay = false
# Bool for determining if kirk is moving to a different room
var movingToDoor = false
# Bool for if the door is open (animation is complete)
var doorOpen = false
# Float to hold kirk's previous y position
var prevYPos = 100
# Reference to kirk
var kirk = null


# Called when the node enters the scene tree for the first time.
func _ready():
	$Confirmation.visible = false
	$ConfirmationBg.visible = false
	kirk = get_parent().get_node("Kirkland")
	get_parent().get_node("Fader").get_node("CanvasModulate").color = Color(1, 1, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") and canPlay:
		play('open')
		kirk.overrideAnim = true
		movingToDoor = true
	
	# Wait until kirk is at the door to start fading
	if movingToDoor and doorOpen:
		if (abs(prevYPos - kirk.position.y) > 0.05):
			prevYPos = kirk.position.y
			kirk.position.y -= 1
		# Fade to black in doorframe
		else:
			kirk.set_modulate(lerp(kirk.get_modulate(), Color(0,0,0,0), 1.0))
			get_parent().get_node("Fader").play("FadeToBlack")


func _on_InteractZone_body_entered(body):
	if body.name == "Kirkland":
		$Confirmation.visible = true
		$ConfirmationBg.visible = true
		canPlay = true
		

func _on_InteractZone_body_exited(body):
	$Confirmation.visible = false
	$ConfirmationBg.visible = false
	canPlay = false


func _on_GooseDoor_animation_finished():
	stop()
	frame = 3
	
	kirk.get_node("body").play('front_back', true)
	kirk.get_node("head").frame = 1
	kirk.velocity = Vector2(0, -1)
	
	doorOpen = true
	


func _on_FadeToBlack_animation_finished(anim_name):
	get_parent().get_node("Fader").stop()
	get_tree().change_scene('res://scenes/RoofKirkGoose.tscn')
