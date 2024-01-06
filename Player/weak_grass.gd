extends Area2D

var hp=1.0
var maxhp = 5.0
var percenthp = 1.0
@onready var player = get_tree().get_first_node_in_group("player")
# Called when the node enters the scene tree for the first time.

func _ready():
	maxhp = hp
	global_position.x = randi_range(0,900)
	global_position.y = randi_range(0,900)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func trim(damage):
	hp -= damage
	percenthp = hp/maxhp
	self.scale = Vector2(sqrt(sqrt(percenthp)), sqrt(sqrt(percenthp)))

	if hp <= 0:
		cut()
	player.recentlycut(self)

func cut():
	queue_free()
	



