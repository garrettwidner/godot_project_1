#character

extends RigidBody2D

func _ready():
	set_physics_process(true)
	set_process_input(true)
	pass


func _physics_process(delta):
	angular_velocity = 0
	pass
	
func _input(event):
	if event.is_action_pressed("jump"):
		
		set_linear_velocity(Vector2(linear_velocity.x, -150))
	 #todo: create ability to jump only when grounded