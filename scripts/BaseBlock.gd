extends StaticBody2D

## Zerstört den Block bei einem Treffer mit dem Ball 
## und sendet den Punktewert an das game-skript.

@export var punkte: int = 10
@export var farbe: Color = Color(1, 1, 1)

## Wird beim Zerstören gesendet. Übergibt den Wert des Blocks.
signal block_zerstoert(punkte_wert)


func _ready():
	$ColorRect.color = farbe


func treffer():
	block_zerstoert.emit(punkte)
	queue_free()
