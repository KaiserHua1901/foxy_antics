extends CharacterBody2D

class_name player 
enum PlayerState {IDLE, RUN, JUMP, FALL, HURT}



const GRAVITY:float = 690.0 
const RUN_SPEED:float = 200.0 
const MAX_FALL:float = 600.0 
const JUMP_VELOCITY:float = -300.0 

@onready var sprite:Sprite2D = $Sprite2D
@onready var debug_label:Label = $DebugLabel
@onready var animation:AnimationPlayer = $AniPlayer 
@onready var shooter: Shooter = $Shooter

var _state:PlayerState = PlayerState.IDLE

func _physics_process(delta: float) -> void:
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
	get_input()
	move_and_slide()
	caculate_state()
	updated_debug_label()
	shooting()
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

func shooting():
	if Input.is_action_just_pressed("bullet"):
		if sprite.flip_h == true:
			shooter.shoot(Vector2.LEFT)
		elif sprite.flip_h == false:
			shooter.shoot(Vector2.RIGHT)


func updated_debug_label() -> void:
	debug_label.text = "floor:%s\n velocity:x(%.0f), y(%.0f) \n state:%s" % [is_on_floor(), velocity.x, velocity.y, PlayerState.keys()[_state] ]

func set_state(new_state:PlayerState):
	if new_state == _state:
		return 
	_state = new_state
	match _state:
		PlayerState.IDLE:
			animation.play("idle")
		PlayerState.RUN:
			animation.play("run")
		PlayerState.FALL:
			animation.play("falling")
		PlayerState.JUMP:
			animation.play("jump")

func caculate_state(): 
	if is_on_floor() == true:
		if velocity.x == 0:
			set_state(PlayerState.IDLE)
		else: 
			set_state(PlayerState.RUN)
	else:
		if velocity.y < 0:
			set_state(PlayerState.JUMP)
		else: 
			set_state(PlayerState.FALL)
