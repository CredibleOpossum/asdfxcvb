extends Label

var offset = 0


func _ready():
	if self.get_parent().get_parent().get_parent().reset_timer_on_restart:
		Global.offset = OS.get_ticks_msec()


func _physics_process(_delta):
	self.text = Global.get_timer()
