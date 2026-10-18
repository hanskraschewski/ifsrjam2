extends CanvasLayer


func focus() -> void:
	%VideoStreamPlayer.play()
	self.visible = true
	
func defocus() -> void:
	%VideoStreamPlayer.stop()
	self.visible = false
