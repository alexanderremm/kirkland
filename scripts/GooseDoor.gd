extends AnimatedSprite


var canPlay = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Confirmation.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") and canPlay:
		play('open')


func _on_InteractZone_body_entered(body):
	$Confirmation.visible = true
	canPlay = true
		

func _on_InteractZone_body_exited(body):
	$Confirmation.visible = false
	canPlay = false


func _on_GooseDoor_animation_finished():
	stop()
	frame = 3
