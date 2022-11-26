
extends RigidBody2D

var shoot = false

const DAMAGE = 50
const SPEED = 10

func _ready():
	set_as_toplevel(true)
	
func _physics_process(delta):
	pass
	#apply_impulse(Vector2 (1,0),Vector2 (1,0)) 


func _on_Area2D_body_entered(body):
	print(body)
	#if body.is_in_group("Enemy"):
	#	body.health -= DAMAGE
	#	queue_free()
	#else:
	#	queue_free() 
