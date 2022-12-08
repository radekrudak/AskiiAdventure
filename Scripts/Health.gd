extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	print("health startup")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print (body)
	if body.has_method("get_damage"):
		health -= body.get_damage()
	print(health)
	



func _on_Area2D_area_entered(area):
	_on_Area2D_body_entered(area)
	pass # Replace with function body.
