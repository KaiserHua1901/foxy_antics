extends Node2D


const OBJECT_SCENES: Dictionary = {
	constants.Object_type.BULLET_PLAYER: preload("res://scenes/bullet_base/bullet_player.tscn"),
	constants.Object_type.BULLET_ENEMY: preload("res://scenes/bullet_base/bullet_enemy.tscn")
}

func _ready() -> void:
	SignalManager.on_create_bullet.connect(on_create_bullet)

func on_create_bullet(
	position: Vector2,
	direction: Vector2,
	life_span: float,
	speed: float,
	object_type: constants.Object_type
) -> void:
	if !OBJECT_SCENES.has(object_type):
		return
	var new_bullet:bullet = OBJECT_SCENES[object_type].instantiate()
	new_bullet.setup(position, direction, speed, life_span)
	call_deferred("add_child", new_bullet)
