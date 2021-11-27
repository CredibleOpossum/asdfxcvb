extends RichTextLabel


func _ready():
	self.text = "Thanks for playing!\nYour final time was: %s" % Global.get_timer()
