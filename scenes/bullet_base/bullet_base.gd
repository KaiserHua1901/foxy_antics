extends Area2D

class_name bullet 

var _direction:Vector2 = Vector2.RIGHT 
var _life_span:float = 5.0 
var _life_time:float = 0.0 

func _process(delta):
	position += _direction * delta * 100
	check_expired(delta)

func check_expired(delta) -> void: #querefree bullet when timer off 
	_life_time += delta 
	if _life_time > _life_span:
		queue_free()
# use for setting up all the value of the bullet when instantance on the scene. 
# It will be define later or use later to check if or is player or enemy bullet. 
func setup(postion:Vector2, direction: Vector2, speed:float, life_span:float) -> void: 
	global_position = postion 
	_direction += direction * speed 
	_life_span = life_span 


func _on_area_entered(area:Area2D) -> void:
	queue_free()
