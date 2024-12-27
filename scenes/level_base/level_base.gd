extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("bullet"):
		SignalManager.on_create_bullet.emit(
			Vector2(500,-50),
			Vector2(50,0),
			3.0,
			50.0,
			constants.Object_type.BULLET_PLAYER
		)
		
	
	
