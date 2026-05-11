extends CharacterBody2D

## Steuert die horizontale Bewegung des Spieler-Paddles.

@export var speed: float = 400.0

func _physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	move_and_slide()
