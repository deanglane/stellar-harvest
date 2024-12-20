extends Area2D

var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()
	
	# get a random position on the Y viewport off screen
	# have sprite spawn at that location instantiate add child?
	# Use a timer node to have it spawn ever second
	
