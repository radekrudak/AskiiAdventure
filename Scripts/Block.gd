extends StaticBody2D


func got_hit(BodyThatColided):
	for child in BodyThatColided.get_children():
		child.queue_free()
	BodyThatColided.queue_free()
	
