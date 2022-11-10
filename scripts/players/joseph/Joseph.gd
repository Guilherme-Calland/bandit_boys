extends KinematicBody2D

export var speed = 80
export var gravity = 10

onready var animationPlayer = $Animation/AnimationPlayer

var motion = Vector2(0,0)
var direction = Directions.SOUTH
enum Directions {
	SOUTH,
	SOUTHEAST,
	EAST,
	NORTHEAST,
	NORTH,
	NORTHWEST,
	WEST,
	SOUTHWEST
}

enum Buttons {
	DOWN,
	RIGHT,
	UP,
	LEFT
}

enum Animations {
	IDLE,
	RUNNING
}


func _process(delta):
	## movement
	
	# vertical
	if buttonPressed(Buttons.DOWN):
		motion.y = speed/2
	elif buttonPressed(Buttons.UP):
		motion.y = -speed/2
	else:
		 motion.y = 0
	
	# horizontal
	if buttonPressed(Buttons.RIGHT):
		motion.x = speed
	elif buttonPressed(Buttons.LEFT):
		motion.x = -speed
	else:
		motion.x = 0
	move_and_slide(motion, Vector2(0, -1))
	
	## direction
	if buttonPressed(Buttons.DOWN):
		if buttonPressed(Buttons.RIGHT):
			direction = Directions.SOUTHEAST
		elif buttonPressed(Buttons.LEFT):
			direction = Directions.SOUTHWEST
		else:
			direction = Directions.SOUTH
	elif buttonPressed(Buttons.UP):
		if buttonPressed(Buttons.RIGHT):
			direction = Directions.NORTHEAST
		elif buttonPressed(Buttons.LEFT):
			direction = Directions.NORTHWEST
		else: 
			direction = Directions.NORTH
	elif buttonPressed(Buttons.RIGHT):
		direction = Directions.EAST
	elif buttonPressed(Buttons.LEFT):
		direction = Directions.WEST
	
	
	## animation	
	var animationKey
	#if motion.x == 0 && motion.y == 0:
	animationKey = Animations.IDLE
	#else:
		#animationParam = Animations.RUNNING
	
	animate(animationKey, direction)

func animate(animationKey, directionKey):
	var key1: String
	var key2: String
	if animationKey == Animations.IDLE:
		key1 = "idle"
	elif animationKey == Animations.RUNNING:
		key1 = "running"
	
	if directionKey == Directions.SOUTH:
		key2 = "south"
	elif directionKey == Directions.SOUTHEAST:
		key2 = "south_east"
	elif directionKey == Directions.EAST:
		key2 = "east"
	elif directionKey == Directions.NORTHEAST:
		key2 = "north_east"
	elif directionKey == Directions.NORTH:
		key2 = "north"
	elif directionKey == Directions.NORTHWEST:
		key2 = "north_west"
	elif directionKey == Directions.WEST:
		key2 = "west"
	elif directionKey == Directions.SOUTHWEST:
		key2 = "south_west"
		
	var joinedKey: String = key1 + "_" + key2
	animationPlayer.play(joinedKey)

func buttonPressed(button):
	if button == Buttons.UP:
		return Input.is_action_pressed("up") and not Input.is_action_pressed("down")
	elif button == Buttons.DOWN:
		return Input.is_action_pressed("down") and not Input.is_action_pressed("up")
	elif button == Buttons.LEFT:
		return Input.is_action_pressed("left") and not Input.is_action_pressed("right")
	elif button == Buttons.RIGHT:
		return Input.is_action_pressed("right") and not Input.is_action_pressed("left")
