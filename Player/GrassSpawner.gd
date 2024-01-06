extends Node2D
var hp = 1.0
var grassspawnrate = 1
@export var SpawnTime = 1.0
@onready var GrassSpawnTimer = $GrassSpawnTimer
var WeakGrass = preload("res://Player/weak_grass.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	GrassSpawnTimer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_grass_spawn_timer_timeout():
	var j = 0
	while j < grassspawnrate:
		var grass = WeakGrass.instantiate()
		grass.hp = hp
		self.add_child(grass)
		j+=1
	GrassSpawnTimer.wait_time=SpawnTime
	GrassSpawnTimer.start()



