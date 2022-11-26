extends Area2D

export var start_direction = Vector2(0,0)
export var velocity = 0

func _ready():
	pass
	#apply_impulse(start_direction , ) 
	
	#print("Shooting projectile")

func _on_Area_body_entered(body):
	pass

func _physics_process(delta):
	self.set_global_position(self.get_global_position()+start_direction*velocity*delta)
	#var CollidedObject = get_last_slide_collision() 
	#if CollidedObject == null:
	#	move_and_slide(start_direction*velocity*delta)
	#else:
	#	#print("projectile hit")
	#	if CollidedObject.has_method("got_hit"):
	#	#	print("block")
	#		CollidedObject.got_hit(self)


func _on_Projectile_body_entered(body):
	print(body) # Replace with function body.
	call_deferred("free")
