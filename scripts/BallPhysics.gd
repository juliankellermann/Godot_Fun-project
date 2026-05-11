extends CharacterBody2D

## Physik- und Bewegungslogik des Balls
## Beinhaltet die Kollisionserkennung mit Blöcken und Wänden 
## sowie die Winkelberechnung wenn der Ball den Rand des Paddles trifft.


const AUFTRIEB_BASIS = -45.0
var kanten_abstand: float 
var ist_am_start = true
var paddle 
@export var speed: float = 300.0

## Initialisiert die Referenz zum Paddle und berechnet dynamisch 
## die äußeren Hitbox-Zonen (jeweils 25% am Rand) für den speziellen Abprall.
func _ready():
	paddle = get_parent().get_node("Paddle")

	if paddle:
		
		var color_rect = paddle.get_node("ColorRect")
		kanten_abstand = color_rect.size.x / 4 


## Berechnet die Bewegung des Balls und löst Kollisionen in jedem Frame auf.
## Enthält modifizierte Abprall-Logik für das Paddle: Trifft der Ball das erste
## oder Letzte viertel des Paddles wird ein anderer Winkel abhängig vom Trefferpunkt berechnet
func _physics_process(delta: float):
	if ist_am_start:
		
		if paddle:
			global_position = paddle.global_position + Vector2(0, -25)
			
		if Input.is_action_just_pressed("ui_accept"):
			abschiessen()
	else:
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			var collider = collision.get_collider()
			var bounce_default = true # Standardmäßig normal abprallen
			
			if collider.name == "Paddle":
				var pos = global_position.x - collider.global_position.x
				
				# Am Rand des Paddles mit speziellem Winkel abprallen, um 
				# dem Spieler gezielte Schüsse zu ermöglichen.
				if pos >= kanten_abstand or pos <= -kanten_abstand:
					
					# pos bestimmt die X-Richtung, AUFTRIEB_BASIS zwingt den Ball nach oben.
					# .normalized() wandelt dieses Verhältnis in den finalen Winkel um.
					var tempSPD = Vector2(pos, AUFTRIEB_BASIS)
					velocity = tempSPD.normalized() * speed
					
					bounce_default = false # Die Standard-Physik überschreiben
					
			if bounce_default:
				if collider.has_method("treffer"):
					collider.treffer()
				# Normaler physikalischer Abprall an Wänden und Blöcken
				velocity = velocity.bounce(collision.get_normal())

func abschiessen():
	ist_am_start = false
	velocity = Vector2(randf_range(-1, 1), -1).normalized() * speed

func _draw():
	var shape_radius = $CollisionShape2D.shape.radius
	draw_circle(Vector2.ZERO, shape_radius, Color.PURPLE)
