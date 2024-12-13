extends CharacterBody2D

class_name player 

const GRAVITY:float = 690.0 
const RUN_SPEED:float = 120.0 
const MAX_FALL:float = 600.0 
const JUMP_VELOCITY:float = -360.0 

@onready var sprite:Sprite2D = $Sprite2D
@onready var debug_label:Label = $DebugLabel


func _physics_process(delta: float) -> void:
    if is_on_floor() == false:
        velocity.y += GRAVITY * delta
    get_input()
    move_and_slide()
    updated_debug_label()
    # print(velocity.y)

func get_input() -> void:
    #stop the movement when not pressed anything
    velocity.x = 0

    # move left 
    if Input.is_action_pressed("left") == true:
        velocity.x = -RUN_SPEED 
        sprite.flip_h = true

    #move right
    elif Input.is_action_pressed("right") == true:
        velocity.x = RUN_SPEED
        sprite.flip_h = false

    if Input.is_action_just_pressed("jump") == true and is_on_floor() == true:
        velocity.y = JUMP_VELOCITY
    velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)

func updated_debug_label() -> void:
    debug_label.text = "floor:%s\n%.0f, %.0f" % [is_on_floor(), velocity.x, velocity.y ]