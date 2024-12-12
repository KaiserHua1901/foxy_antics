extends CharacterBody2D

class_name player 

const GRAVITY:float = 690.0 




func _physics_process(delta: float) -> void:
    if is_on_floor() == false:
        velocity.y += GRAVITY * delta
    move_and_slide()
