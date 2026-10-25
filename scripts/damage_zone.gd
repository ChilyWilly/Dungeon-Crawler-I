extends Area2D

var max_health = 100


func _on_body_entered(_body: Node2D) -> void:
	Global.health -= 20
	if Global.health <= 0:
		Global.health = 0
		print("You Died")
		Global.health = 100
		get_tree().reload_current_scene()
	else:
		print(Global.health)
