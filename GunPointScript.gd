extends Node


var BulletScene 
onready var FrontIron = $FrontIron
# Called when the node enters the scene tree for the first time.
func _ready():
	BulletScene =	 preload("res://Scenes/Projectile.tscn")
 # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#bullet spawn
	if Input.is_action_pressed("attack"):
		var BulletInstance = BulletScene.instance()
		BulletInstance.global_position = self.global_position 
		
		#set ups bullet to move in direction player is looking at 
		var distance_to_front_iron = self.global_position.distance_to(FrontIron.global_position)
		BulletInstance.start_direction = (FrontIron.global_position-self.global_position)/distance_to_front_iron #FrontIron.global_position / Vector2(distance_to_front_iron,distance_to_front_iron)

		get_tree().get_root().get_node("Game").add_child( BulletInstance )

