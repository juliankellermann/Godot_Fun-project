extends Node2D

## Hauptsteuerung des Spielablaufs
## Verwaltung von Leben und Score, Spawnen der Blöcke am Start
## Zerstören und ersetzen des Balls wenn er die Todeszone betritt sowie auslösen des Game-Over-Screens.

var block_bauplan = preload("res://scenes/block.tscn")
var ball_bauplan = preload("res://scenes/ball.tscn")

var score = 0
var leben = 3
var geld = 0
var ziel_score = 100 

# Called when the node enters the scene tree for the first time.
## Spawnt den Block-grid und den ersten Ball
func _ready():
	
	var spalten = 6 
	var reihen = 7  
	
	var abstand_x = 130 
	var abstand_y = 50 
	
	
	var start_x = -320
	var start_y = -1
	
	
	for y in range(reihen):          
		for x in range(spalten):    
			
			
			var neuer_block = block_bauplan.instantiate()
			neuer_block.block_zerstoert.connect(_on_block_zerstoert)
			
			
			var pos_x = start_x + (x * abstand_x)
			var pos_y = start_y + (y * abstand_y)
			neuer_block.position = Vector2(pos_x, pos_y)
			
			
			$Bloecke.add_child(neuer_block)
	
	spawn_ball() 


func _on_block_zerstoert(punkte_wert):
	
	score += punkte_wert
	
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)


func _on_death_zone_body_entered(body):
		
	if body.has_method("abschiessen"):
		
		print("Erfolgreich als Ball erkannt! Leben wird abgezogen.")
		body.queue_free()
		ball_verloren()


## Verringert die Leben um 1 und prüft den Spielstatus.
## Haben wir noch Leben, wird ein neuer Ball verzögert gespawnt. 
## Bei 0 Leben wird stattdessen der Game-Over-Bildschirm aufgerufen.
func ball_verloren():
	leben -= 1
	$CanvasLayer/LivesLabel.text = "Leben: " + str(leben)
	if leben > 0:
		call_deferred("spawn_ball") ## call_deferred verhindert Kollisions-Fehler mit der Physik-Engine
	else:
		game_over()


func spawn_ball():
	var neuer_ball = ball_bauplan.instantiate()
	neuer_ball.paddle = $Paddle
	add_child(neuer_ball)


func game_over():
	print("Game Over!")
	$CanvasLayer/GameOverMenu.show()


func _on_restart_button_pressed():
	get_tree().call_deferred("reload_current_scene")
	$CanvasLayer/GameOverMenu.hide()
