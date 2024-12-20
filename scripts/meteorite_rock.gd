extends Area2D

class_name meteorite

var speed = 100
signal meteorite_off_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()
		meteorite_off_screen.emit()
		
