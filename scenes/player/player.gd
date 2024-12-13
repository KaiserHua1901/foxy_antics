extends CharacterBody2D

class_name player 

const GRAVITY:float = 690.0 
const RUN_SPEED:float = 120.0 
const MAX_FALL:float = 600.0 
const JUMP_VELOCITY:float = -360.0 

@onready var Sprite:Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
    if is_on_floor() == false:
        velocity.y += GRAVITY * delta
    get_input()
    move_and_slide()
    # print(velocity.y)

func get_input() -> void:
    #stop the movement when not pressed anything
    velocity.x = 0
    # move left 
    if Input.is_action_pressed("left") == true:
        velocity.x = -RUN_SPEED 
        Sprite.flip_h = true
    #move right
    elif Input.is_action_pressed("right") == true:
        velocity.x = RUN_SPEED
        Sprite.flip_h = false

    if Input.is_action_just_pressed("jump") == true and is_on_floor() == true:
        velocity.y = JUMP_VELOCITY
    velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)

