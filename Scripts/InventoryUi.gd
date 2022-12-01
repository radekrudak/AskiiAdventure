extends Popup


var isDebugMenuClosed = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		self.popup()
	


func _on_CloseInventory_pressed():
	self.visible = false;
