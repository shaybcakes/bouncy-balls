extends StaticBody2D

@export var num_sides:int = 20
@export var radius:float = 200
@export var hole:int = 0 #of sides left open
@export var color:Color = Color("CYAN")

func _ready() -> void:
	var player:AudioStreamPlayer2D = get_child(0)
	player.set_volume_db(-80)
	draw_collide()
	

func draw_collide():
	print("CHECKME:"+str((PI * 2 * radius) / num_sides))
	while (PI * 2 * radius) / num_sides + ((PI * 2 * radius) / num_sides * hole) < 45:
		hole = hole + 1
	print("CHECKME:HOLE:"+str(hole))
	var cshape = CollisionPolygon2D.new()
	var breakpoly: PackedVector2Array
	#cshape.position = position
	add_child(cshape)
	cshape.set_build_mode(0)
	var angle_delta:float = (PI * 2) / num_sides
	var vector: Vector2 = Vector2(radius,0)
	breakpoly.append(vector)
	var polygon:PackedVector2Array
	for _i in num_sides-hole:
		polygon.append(vector)
		vector = vector.rotated(angle_delta)
	vector = vector.rotated(angle_delta * -1)
	breakpoly.append(vector)
	vector = vector.normalized() * (radius - 10)
	breakpoly.append(vector)
	for _i in num_sides-hole:
		polygon.append(vector)
		vector = vector.rotated(angle_delta * -1)
	vector = vector.rotated(angle_delta)
	breakpoly.append(vector)
	cshape.set_polygon(polygon)
	print(polygon)
	var viz = Polygon2D.new()
	#viz.position = position
	add_child(viz)
	
	viz.set_polygon(polygon)
	viz.set_color(color)
	var breakarea = Area2D.new()
	var breakshape = CollisionPolygon2D.new()
	add_child(breakarea)
	breakarea.add_child(breakshape)
	breakshape.set_polygon(breakpoly)
	breakarea.body_entered.connect(_body_entered)
	
	
func _body_entered(body):
	if body.name == "Ball" and not is_queued_for_deletion():
		for child in get_children():
			print(child)
			if child.name == "AudioStreamPlayer2D":
				print("yes")
				print(child.get_playback_position())
				child.set_volume_db(0.0)
			else: child.queue_free()
		#queue_free()
