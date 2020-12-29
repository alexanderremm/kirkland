extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fader/CanvasModulate.color = Color(0, 0, 0, 0)
	$Fader.play("FadeFromBlack")
