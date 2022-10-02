extends KinematicBody2D

export var speed = 80
export var gravity = 10

onready var animationPlayer = $Animation/AnimationPlayer

var motion = Vector2(0,0)

func _process(delta):
	if Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		motion.y = -speed/2
	elif Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		motion.y = speed/2
	else:
		 motion.y = 0
	
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = speed
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -speed
	else:
		motion.x = 0
		
	if motion.x == 0 && motion.y == 0:
		animationPlayer.play("idle_south")
	else:
		animationPlayer.play("running_south")
	move_and_slide(motion, Vector2(0, -1))
