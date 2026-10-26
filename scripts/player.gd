extends CharacterBody2D


var speed = 100.0
var attack = false


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var map_collision: CollisionShape2D = $MapCollision
@onready var attack_sprite: AnimatedSprite2D = $AttackSprite


func _process(_delta: float) -> void:

	# Left and right movement
	var horizontal := Input.get_axis("move_left", "move_right")
	if horizontal:
		velocity.x = horizontal * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# Up and down movement
	var vertical := Input.get_axis("move_up", "move_down")
	if vertical:
		velocity.y = vertical * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
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
		
	# Enables player debug mode
	if Input.is_action_just_pressed("player_debug"):
		speed = 200
		# Toggle the disabled state once
		map_collision.disabled = !map_collision.disabled
	
		if map_collision.disabled:
			animated_sprite.modulate = Color.BLACK
		else:
			animated_sprite.modulate = Color.WHITE
			speed = 100
	
	# Adds the attack animation (WIP)
	if Input.is_action_just_pressed("player_atk"):
		attack = true
		if attack == true:
			if Input.is_action_pressed("player_atk") and animated_sprite.flip_h == false and horizontal == 1:
				animated_sprite.play("side_atk")
				animated_sprite.offset.x += 8
			elif Input.is_action_pressed("player_atk") and animated_sprite.flip_h == true and horizontal == -1:
				animated_sprite.play("side_atk")
				animated_sprite.offset.x += -8
			elif Input.is_action_pressed("player_atk") and horizontal + vertical == 0:
				animated_sprite.play("down_atk")
				animated_sprite.offset.y += 7
			elif Input.is_action_pressed("player_atk") and vertical == -1:
				animated_sprite.play("up_atk")
				animated_sprite.offset.y += -9
			elif Input.is_action_pressed("player_atk") and vertical == 1:
				animated_sprite.play("down_atk")
				animated_sprite.offset.y += 7
			timer.start()

	move_and_slide()


func _on_timer_timeout() -> void:
	animated_sprite.offset.x = 0
	animated_sprite.offset.y = 0
	attack = false
