extends CharacterBody2D

class_name  EnemyBase 

var _player_ref: player 
const FALL_OFF_SCENE: float = 300

@export var point:int = 1
var _gravity: float = 700.0 
var _dying:bool = false

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(constants.PLAYER_GROUP)
	
func _physics_process(delta: float) -> void:
	enemy_fall_off_scene() 
	
func enemy_fall_off_scene() -> void:
	if global_position.y > FALL_OFF_SCENE:
		queue_free()

func die() ->void: 
	if _dying == true:
		return 
	_dying = true 
	_physics_process(false)
	hide()
	queue_free()
	


func _on_hit_box_area_entered(area: Area2D) -> void:
	die()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass
