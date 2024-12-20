extends Area2D

@onready var cargo_ship: Sprite2D = $Sprite2D
@onready var meteorite_rock: Area2D = $"../Meteorite-rock"


const SPEED: float = 350.0
var speed2: float = SPEED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Movement inputs
	if Input.is_action_pressed("left"):
		# cargo left speed
		position.x += -speed2 * delta
		# cargo sprite directions
		cargo_ship.flip_h = false
		# stopping cargo from going off the screen
		if position.x - 50 < get_viewport_rect().position.x:
			print("Left Stop")
	elif Input.is_action_pressed("right"):
		# cargo left speed
		position.x += speed2 * delta
		# cargo sprite directions
		cargo_ship.flip_h = true
		# stopping cargo from going off the screen
		if position.x + 50 > get_viewport_rect().size.x:
			print("Right Stop")

func _on_area_entered(area: Area2D) -> void:
	print("something hit the ship")
	meteorite_rock.queue_free()
	var score = 0
	score += 1
	print(score)
	
