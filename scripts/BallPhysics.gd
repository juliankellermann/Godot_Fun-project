extends CharacterBody2D

## Physik- und Bewegungslogik des Balls
## Beinhaltet die Kollisionserkennung mit Blöcken und Wänden 
## sowie die Winkelberechnung wenn der Ball den Rand des Paddles trifft.


const AUFTRIEB_BASIS = -45.0
const START_Y_OFFSET = -25
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
func _physics_process(delta: float) -> void:
	if ist_am_start:
		_handle_start_state()
	else:
		_handle_movement(delta)


func _handle_start_state() -> void:
	if paddle: 
		global_position = paddle.global_position + Vector2(0, START_Y_OFFSET)
		
	if Input.is_action_just_pressed("ui_accept"):
		abschiessen()


func _handle_movement(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if not collision:
		return
		
	_resolve_collision(collision)


func _resolve_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	
	if _try_paddle_bounce(collider):
		return
		
	_apply_standard_bounce(collision)


## Prüft, ob der Ball das Paddle an den Rändern trifft. 
## Gibt true zurück, wenn die Flugbahn modifiziert wurde.
func _try_paddle_bounce(collider: Object) -> bool:
	if collider.name != "Paddle":
		return false
		
	var hit_offset_x: float = global_position.x - collider.global_position.x
	
	if abs(hit_offset_x) >= kanten_abstand:
		var bounce_direction := Vector2(hit_offset_x, AUFTRIEB_BASIS).normalized()
		velocity = bounce_direction * speed
		return true
		
	return false


## Führt den normalen physikalischen Abprall und Treffer-Logik aus.
func _apply_standard_bounce(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	
	if collider.has_method("treffer"):
		collider.treffer()
		
	velocity = velocity.bounce(collision.get_normal())

func abschiessen():
	ist_am_start = false
	velocity = Vector2(randf_range(-1, 1), -1).normalized() * speed

func _draw():
	var shape_radius = $CollisionShape2D.shape.radius
	draw_circle(Vector2.ZERO, shape_radius, Color.PURPLE)
