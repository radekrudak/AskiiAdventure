extends KinematicBody2D

onready var GunPoint = $GunPoint
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
export var speed = 10000.0
export var slowing_speed = 1.8
var Block = null
func _physics_process(delta):
	
	look_at(get_global_mouse_position())
	
	GunPoint.set_VisualSight_global_position(
		get_global_mouse_position()
		)
	
	if Input.is_action_pressed("move_left"):
		velocity.x-=speed*delta
	if Input.is_action_pressed("move_right"):
		velocity.x+=speed*delta
	if Input.is_action_pressed("move_up"):
		velocity.y-=speed*delta
	if Input.is_action_pressed("move_down"):
		velocity.y+=speed*delta
	if Input.is_action_pressed("ui_accept"):
		add_child(Block.instance())
		
	move_and_slide(velocity,Vector2(0,1))
	velocity = velocity / Vector2(slowing_speed,slowing_speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	Block = load("res://Scenes/Block.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
