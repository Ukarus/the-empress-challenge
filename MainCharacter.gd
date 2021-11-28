extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 400
var state_machine
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	state_machine = $AnimationTree.get("parameters/playback")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_just_pressed("ui_attack"):
		state_machine.travel("attack1")
		return
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$Sprite.scale.x = 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$Sprite.scale.x = -1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		state_machine.travel("run")
	if velocity.length() == 0:
		state_machine.travel("idle")
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

