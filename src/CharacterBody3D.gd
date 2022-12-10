extends CharacterBody3D
class_name Player

@export @onready var camera:Camera3D = get_viewport().get_camera_3d()

@export var max_stamina:int = 100
var stamina:float = max_stamina:
	get: return stamina
	set(value):
		stamina = value
		stamina = clamp(stamina, 0, max_stamina)


@onready var stamina_regain_delay = $StaminaRegainDelay

@export var stamina_depletion = 10
@export var stamina_regain = 20

enum CHARACTER_STATES {
	IDLE,
	MOVING,
	JUMPING,
	FALLING
}

enum MOVEMENT_STATES {
	WALKING,
	RUNNING
}

@export var movement_state = MOVEMENT_STATES.WALKING

@export var character_state = CHARACTER_STATES.IDLE

@export var ground_friction = 15
@export var air_friction = 1

@export var jump_force:float = 7

@export var ground_speed = 50
@export var ground_running_speed = 90

@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") / 20

func _input(event):
	if event is InputEvent:
		if !character_state in [CHARACTER_STATES.FALLING, CHARACTER_STATES.JUMPING]:
			if event.is_action_pressed("action_jump"):
				velocity.y += jump_force
				character_state = CHARACTER_STATES.JUMPING

func _physics_process(delta):
	var input_vector:Vector2 = Vector2(Input.get_axis("move_left", 'move_right'), Input.get_axis("move_backwards", "move_foward"))

	match character_state:
		CHARACTER_STATES.IDLE:
			apply_friction(ground_friction, delta)
			
			if input_vector.length() != 0:
				character_state = CHARACTER_STATES.MOVING
				
			if !is_on_floor():
				character_state = CHARACTER_STATES.FALLING
		
			if stamina_regain_delay.is_stopped():
				stamina_regain_delay.start()
				stamina += 10
		
		CHARACTER_STATES.MOVING:
			match movement_state:
				MOVEMENT_STATES.WALKING:
					apply_friction(ground_friction, delta)
					move(input_vector, ground_speed, delta)
					
					if stamina != 0:
						if Input.is_action_just_pressed("action_run"):
							movement_state = MOVEMENT_STATES.RUNNING
				MOVEMENT_STATES.RUNNING:
					apply_friction(ground_friction, delta)
					move(input_vector, ground_running_speed, delta)
					
					stamina -= stamina_depletion * delta
					
					if Input.is_action_just_released("action_run") || stamina == 0:
						movement_state = MOVEMENT_STATES.WALKING
					
			if input_vector.length() == 0:
				character_state = CHARACTER_STATES.IDLE
				movement_state = MOVEMENT_STATES.WALKING
				
			if !is_on_floor():
				character_state = CHARACTER_STATES.FALLING
				movement_state = MOVEMENT_STATES.WALKING
				
		CHARACTER_STATES.JUMPING:
			apply_friction(air_friction, delta)
			velocity.y -= gravity
			
			if velocity.y < 0:
				character_state = CHARACTER_STATES.FALLING
				
		CHARACTER_STATES.FALLING:
			apply_friction(air_friction, delta)
			velocity.y -= gravity
			
			if is_on_floor():
				character_state = CHARACTER_STATES.MOVING
	
	move_and_slide()

func move(input_vector:Vector2, speed:float, delta) -> void:
	var dir:Vector3 = Vector3((camera.basis.x.x * input_vector.x) + (-camera.basis.z.x * input_vector.y), 0, (-camera.basis.z.z * input_vector.y) + (camera.basis.x.z * input_vector.x))
	
	velocity += dir.normalized() * speed * delta
	
func apply_friction(friction:float, delta) -> void:
	velocity.x -= velocity.x * friction * delta
	velocity.z -= velocity.z * friction * delta
