extends KinematicBody2D

const walk_speed = 75
const run_speed = 120
const jump_force = 400
const gravity = 25
const max_fall_speed = 1000

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite

var current_speed = 0
var y_velo = 0
var facing_right = true

func _physics_process(delta):
	if Input.is_action_pressed("action1"):
		current_speed = run_speed
	else:
		current_speed = walk_speed
	
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * current_speed, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	y_velo += gravity
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -jump_force
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > max_fall_speed:
		y_velo = max_fall_speed
	
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
		
	if grounded:
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	elif y_velo > 0:
		play_anim("fall")
	else:
		play_anim("jump")

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	