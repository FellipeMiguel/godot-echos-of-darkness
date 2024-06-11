extends Sprite
class_name PlayerTexture

var normal_attack: bool = false
var suffix: String = "_right"

export(NodePath) onready var animation = get_node(animation) as AnimationPlayer
export(NodePath) onready var player = get_node(player) as KinematicBody2D

func animate(direction: Vector2) -> void:
	verify_position(direction)
	if player.attacking:
		action_behavior()
	elif direction.y != 0:
		vertical_behavior(direction)
	else:	
		horizontal_behavior(direction)
	
func verify_position(direction: Vector2):
	if direction.x > 0:
		flip_h = false
		suffix = "_right"
	elif direction.x < 0:
		flip_h = true
		suffix = "_left"

func action_behavior() -> void:
	if player.attacking and normal_attack:
		animation.play("attack" + suffix)

func horizontal_behavior(direction: Vector2) -> void:
	if direction.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

func vertical_behavior(direction: Vector2) -> void:
	if direction.y > 0:
		animation.play("fall")
	elif direction.y < 0:
		animation.play("jump")


func on_animation_finished(anim_name):
	match anim_name:
		"attack_left":
			normal_attack = false
			player.attacking = false
			
		"attack_right":
			normal_attack = false
			player.attacking = false
