extends Area2D

var health = 100


func _on_body_entered(_body: Node2D) -> void:
	health -= 20
	if health <= 0:
		health = 0
		print("You Died")
		get_tree().reload_current_scene()
	else:
		print(health)
