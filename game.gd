extends Node2D

@onready var cam:Camera2D = $RigidBody2D3/Camera2D
@onready var ball:RigidBody2D = $Ball
@onready var capsule:PackedScene = preload("res://capsule.tscn")
@export var speed: float = 100
var radius = 250
var numsides = 45
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ball.apply_central_impulse(Vector2(100,-100))
	for node in $Capsules.get_children():
		node.rotation_degrees = randi_range(0,360)
func _physics_process(delta: float) -> void:
	for node in $Capsules.get_children():
		node.rotation_degrees = node.rotation_degrees + speed
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_G:
			var new_cap = capsule.instantiate()
			#new_cap.position = $Capsules.position
			
			new_cap.radius = radius - (len($Capsules.get_children())*20)
			new_cap.num_sides = numsides
			#radius = radius - 20
			#numsides = numsides-1
			new_cap.draw_collide()
			#add_child(new_cap)
			$Capsules.add_child(new_cap)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
