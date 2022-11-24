extends KinematicBody2D

export var start_direction = Vector2(1,0)
export var velocity = 200000

func _ready():
	pass
	#print("Shooting projectile")


func _physics_process(delta):
	move_and_slide(start_direction*velocity*delta)
