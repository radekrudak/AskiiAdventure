extends Node


var BulletScene 
var isCoolDownEnded = true 

onready var CoolDownTimer = $CoolDownTimer
onready var FrontIron = $FrontIron


# Called when the node enters the scene tree for the first time.
func _ready():
	BulletScene =	 preload("res://Scenes/Projectile.tscn")
	CoolDownTimer.one_shot = true
	CoolDownTimer.wait_time = 0.5
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#bullet spawn
	if Input.is_action_just_pressed("attack")  and isCoolDownEnded: #Input.is_action_pressed("attack")
		var BulletInstance = BulletScene.instance()
		BulletInstance.global_position = self.global_position 
		
		#set ups bullet to move in direction player is looking at 
		var distance_to_front_iron = self.global_position.distance_to(FrontIron.global_position)
		BulletInstance.start_direction = (FrontIron.global_position-self.global_position)/distance_to_front_iron #FrontIron.global_position / Vector2(distance_to_front_iron,distance_to_front_iron)
		BulletInstance.look_at(FrontIron.get_global_position())
		get_tree().get_root().get_node("Game").add_child( BulletInstance )
		CoolDownTimer.start()
		isCoolDownEnded = false




func _on_CoolDownTimer_timeout():
	isCoolDownEnded = true
	
func set_cool_down(cool_down):
	CoolDownTimer.wait_time = cool_down


