extends Node2D
class_name Shooter 

@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_audio: AudioStreamPlayer2D = $ShootAudio

@export var speed:float = 150.0
@export var life_span:float = 3.0
@export var bullet_key:constants.Object_type
@export var shoot_delay:float = 0.7

var can_shoot:bool = true

func _ready() -> void:
	shoot_timer.wait_time = shoot_delay


func shoot(direction:Vector2) -> void:
	if can_shoot == false: 
		return
	can_shoot = false 
	SignalManager.on_create_bullet.emit(global_position,direction,life_span,speed,bullet_key)
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	can_shoot = true