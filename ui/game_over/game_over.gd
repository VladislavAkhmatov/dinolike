extends CanvasLayer

func _on_button_pressed():
	get_tree().reload_current_scene()


func _on_magazine_pressed():
	get_tree().change_scene_to_file("res://ui/shop/shop.tscn")
