extends RigidBody2D

#var maxy
#
#var heightlist = []
#
#func _physics_process(delta: float) -> void:
	#if not maxy:
		#maxy = position.y
	#else:
		#var new_y = position.y
		#if new_y > maxy: maxy = position.y
		#else:
			#var height = maxy - new_y
			#heightlist.append(height)
	#if len(heightlist) > 5:
		#if heightlist[-2]>heightlist[-1] and heightlist[-2]>heightlist[-3]:
			#print("maximum:"+str(heightlist[-2]))
#
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.pressed:
		#if event.keycode == KEY_F:
			#heightlist.sort()
			#print(heightlist)
