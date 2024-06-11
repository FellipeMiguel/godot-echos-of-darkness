extends KinematicBody2D
class_name Player

onready var player_sprite: Sprite = get_node("Texture")

var velocity: Vector2

var jump_count: int = 0

var attacking: bool = false

export(int) var speed
export(int) var jump_speed

export(int) var player_gravity

func _physics_process(delta: float):
	horizontal_movement_env()
	vertical_moviment_env()
	actions_env()
	
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	player_sprite.animate(velocity)
	
func horizontal_movement_env() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if attacking:
		velocity.x = 0
		return
	velocity.x = input_direction * speed

func vertical_moviment_env() -> void:
	if is_on_floor():
		jump_count = 0
		
	var jump_condition: bool = not attacking
	if Input.is_action_just_pressed("ui_up") and jump_count < 2 and jump_condition:
		jump_count += 1
		velocity.y = jump_speed
		
func actions_env() -> void:
	attack()
	
func attack() -> void:
	var attack_condition: bool = not attacking
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		attacking = true
		player_sprite.normal_attack = true
	
func gravity(delta: float) -> void:
	velocity.y += delta * player_gravity
	if velocity.y >= player_gravity:
		velocity.y = player_gravity
