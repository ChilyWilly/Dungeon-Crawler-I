extends Area2D

var max_health = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var hit = false

func _on_body_entered(_body: Node2D) -> void:
	var hit = true
	Global.health -= 10
	if Global.health <= 0:
		Global.health = 0
		print("You Died")
		Global.health = 100
		get_tree().reload_current_scene()
		animated_sprite.play("hit_down")
	else:
		print(Global.health)
