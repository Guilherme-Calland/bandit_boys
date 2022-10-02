extends KinematicBody

var motion = Vector3.ZERO
export var speed = 1.0
export var gravity = 0.2
onready var animationPlayer = $Animation/AnimationPlayer

func _process(delta):
	
	if(Input.is_action_pressed("up") and not Input.is_action_pressed("down")):
		motion.z = -speed
	elif (Input.is_action_pressed("down") and not Input.is_action_pressed("up")):
		motion.z = speed
	else:
		 motion.z = 0
	
	if(Input.is_action_pressed("left") and not Input.is_action_pressed("right")):
		motion.x = -speed
	elif(Input.is_action_pressed("right") and not Input.is_action_pressed("left")):
		motion.x = speed
	else:
		motion.x = 0
	
	if(is_on_floor()):
		motion.y = -1
		if(motion.x != 0 or motion.z != 0):
				animationPlayer.play("running_south")
		else:
				animationPlayer.play("idle_south")
	else:
		motion.y -= gravity
		if(animationPlayer.is_playing()):
			animationPlayer.play("falling_south")
		
	move_and_slide(motion, Vector3.UP)

func _on_Area_body_entered(body):
	translation = Vector3(0,0,0)
