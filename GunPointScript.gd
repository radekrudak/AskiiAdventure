extends Node

enum FireMode {SAFE, SINGLE_SHOT, AUTO}

var StringToFireMode = {
	null:FireMode.SAFE,
	"SAFE":FireMode.SAFE,
	"SINGLE_SHOT":FireMode.SINGLE_SHOT,
	"AUTO":FireMode.AUTO
	}
export var is_weapon_equiped = false
export var damage = 10
export var mode_index = 0 # index points in which mode from avalible_modes array gun is in
export var avalible_modes = [FireMode.SAFE,FireMode.SINGLE_SHOT,FireMode.AUTO];

var BulletScene 
var isCoolDownEnded = true 

onready var CoolDownTimer = $CoolDownTimer
onready var FrontIron = $FrontIron
onready var VisualSight = $VisualSightPos/VisualSight
onready var VisualSightAnimationPlayer = $VisualSightPos/AnimationPlayer
onready var VisualSightPos = $VisualSightPos
# Called when the node enters the scene tree for the first time.
func _ready():
	#laod and setup 
	BulletScene = preload("res://Scenes/Projectile.tscn")
	
func shoot_bullet():
	var BulletInstance = BulletScene.instance()
	BulletInstance.global_position = self.global_position 
	
	#set ups bullet to move in direction player is looking at 
	var distance_to_front_iron = self.global_position.distance_to(FrontIron.global_position)
	BulletInstance.start_direction = (FrontIron.global_position-self.global_position)/distance_to_front_iron #FrontIron.global_position / Vector2(distance_to_front_iron,distance_to_front_iron)
 
	BulletInstance.damage = damage
	
	# adds bullet to scene
	get_tree().get_root().get_node("Game").add_child( BulletInstance )

	BulletInstance.look_at(FrontIron.get_global_position())
	
	BulletInstance.global_position = FrontIron.global_position
	#resets timer
	CoolDownTimer.start()
	isCoolDownEnded = false

	VisualSightAnimationPlayer.play("ShootRecoil")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	VisualSight.value = VisualSight.max_value-(CoolDownTimer.time_left/CoolDownTimer.wait_time * VisualSight.max_value) 
	if is_weapon_equiped:
		if Input.is_action_just_pressed("change_fire_mode"):
			change_fire_mode()
		#bullet spawn
		if get_fire_mode() != FireMode.SAFE  and isCoolDownEnded: #Input.is_action_pressed("attack")
			match get_fire_mode():
				FireMode.SINGLE_SHOT:
					if Input.is_action_just_pressed("attack") :
						shoot_bullet()
				FireMode.AUTO:
					if Input.is_action_pressed("attack"):
						shoot_bullet()


func get_fire_mode():
	return avalible_modes[mode_index % avalible_modes.size()]

func change_fire_mode():
	mode_index +=1
	mode_index %= avalible_modes.size()
	#print(mode_index," ", avalible_modes.size())#

func _on_CoolDownTimer_timeout():
	isCoolDownEnded = true
	
func set_cool_down(cool_down):
	CoolDownTimer.wait_time = cool_down


func set_damage(new_damage_val):
	damage = new_damage_val


func _on_ItemSlot_item_set(item_just_equiped):
	is_weapon_equiped = true
	#print(item_just_equiped.get_property("damage"))
	damage = item_just_equiped.get_property("damage")
	var avalible_modes_strings = item_just_equiped.get_property("fire_modes",null)
	if avalible_modes_strings != null:
		avalible_modes.clear()
		for i in avalible_modes_strings:
			#print(i, StringToFireMode[i])
			avalible_modes.append(StringToFireMode[i])
		#print(avalible_modes)
	set_cool_down(item_just_equiped.get_property("cool_down",1))
	


func _on_ItemSlot_item_cleared():
	is_weapon_equiped = false

func set_VisualSight_global_position(val):
	VisualSightPos.set_global_position(val)
