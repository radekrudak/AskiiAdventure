extends PopupMenu


var isDebugMenuClosed = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDebugMenuClosed && Input.is_action_just_pressed("debug_window"):
		self.popup()
	
