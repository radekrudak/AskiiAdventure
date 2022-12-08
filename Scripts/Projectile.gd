extends Area2D

export var damage = 10
export var start_direction = Vector2(0,0)
export var velocity = 0

func _physics_process(delta):
	#moves projectile
	self.set_global_position(self.get_global_position()+start_direction*velocity*delta)

func get_damage():
	return damage

func _on_Projectile_body_entered(body):
	#colysion detection, if hit soemthing destroy itselfw
	call_deferred("free")


func _on_Timer_timeout():
	call_deferred("free")
	
