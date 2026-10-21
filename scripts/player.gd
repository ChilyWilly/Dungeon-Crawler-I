extends CharacterBody2D


const SPEED = 100.0
var attack = false
var attempts = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


func _process(_delta: float) -> void:

	# Left and right movement
	var horizontal := Input.get_axis("move_left", "move_right")
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Up and down movement
	var vertical := Input.get_axis("move_up", "move_down")
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	# Flip the sprite horizontally
	if horizontal > 0:
		animated_sprite.flip_h = false
	elif horizontal < 0:
		animated_sprite.flip_h = true

	# Play animations
	if attack == false:
		if horizontal == 0 and vertical == 0:
			animated_sprite.play("idle")
		elif horizontal == 0 and vertical < 0:
			animated_sprite.play("run_up")
		elif horizontal == 0 and vertical > 0:
			animated_sprite.play("run_down")
		else: animated_sprite.play("run_side")
	
	# Adds the attack animation (WIP)
	if Input.is_action_just_pressed("player_atk"):
		attack = true
		if attack == true:
			if Input.is_action_pressed("player_atk") and animated_sprite.flip_h == false and horizontal == 1:
				animated_sprite.play("side_atk")
			elif Input.is_action_pressed("player_atk") and animated_sprite.flip_h == true and horizontal == -1:
				animated_sprite.play("side_atk")
			elif Input.is_action_pressed("player_atk") and horizontal + vertical == 0:
				animated_sprite.play("down_atk")
			elif Input.is_action_pressed("player_atk") and vertical == -1:
				animated_sprite.play("up_atk")
			elif Input.is_action_pressed("player_atk") and vertical == 1:
				animated_sprite.play("down_atk")
			timer.start()

	move_and_slide()


func _on_timer_timeout() -> void:
	attack = false
