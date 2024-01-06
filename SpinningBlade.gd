extends Area2D

#BladeStats
var Damage = 1
var SpinSpeed = 1
var idleSpinSpeed = 0.01
var Size = 0.5
var MoveSpeed = 500
var direction = Vector2.ZERO
var mouse = false
var money = 0
var upgrades = ["size", "damage", "idlespinspeed", "spinspeed", "grassspawnrate",  "grasshealth","bladecount"]
var upgradestats = ["size", "damage", "idlespinspeed", "spinspeed", "grassspawnrate", "grasshealth", "bladecount"]
var upgradecost = [5,5,5,5,5,5,5]

@export var RecentlyCut = []
@onready var MoneyLabel = $"../GUI/Money"
@onready var ShopButton = $"../GUI/Shop"
@onready var ShopOptions = $"../GUI/ShopOptions"
@onready var grassSpawner = $"../GrassSpawner"
@onready var SizeButton = $"../GUI/ShopOptions/Size"
@onready var DamageButton = $"../GUI/ShopOptions/Damage"
@onready var IdleSpinSpeedbutton = $"../GUI/ShopOptions/idleSpinSpeed"
@onready var SpinSpeedButton = $"../GUI/ShopOptions/SpinSpeed"
@onready var GrassSpawnRateButton = $"../GUI/ShopOptions/GrassSpawnRate"
@onready var BladeCountButton = $"../GUI/ShopOptions/BladeCount"
@onready var GrassHealthButton = $"../GUI/ShopOptions/GrassHealth"


var rotated_amount = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = Vector2(Size, Size)
	updatemoney()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moneycheck()
	if mouse:
		self.rotate(-SpinSpeed*delta - idleSpinSpeed*delta)
		rotated_amount += SpinSpeed*delta + idleSpinSpeed*delta
	if not mouse:
		self.rotate(-idleSpinSpeed*delta)
		rotated_amount += idleSpinSpeed
	self.scale = Vector2(Size, Size)
	if rotated_amount >= 6:
		rotated_amount = 0
		RecentlyCut = []
	#delayedmovement
	#direction = global_position.direction_to(get_global_mouse_position())
	#global_position += direction * MoveSpeed * delta
	
	#realtimemovement
	#global_position = get_global_mouse_position()
	


func _on_blade_mouse_entered():
	mouse=true

func _on_blade_mouse_exited():
	mouse=false

func moneycheck():
	var cantbuy = []
	var j = 0
	for i in upgradecost:
		if money < i:
			cantbuy.append(upgrades[j])
		j+=1
	print(str(cantbuy))

func _on_area_entered(area):
	if area.is_in_group("grass"):
		if area in RecentlyCut:
			pass
		else:
			area.trim(Damage)
			money = cleannumber(money+Damage)
			MoneyLabel.text=str("$" , money)


func recentlycut(object):
	RecentlyCut.append(object)
	














func _on_shop_pressed():
	if ShopOptions.visible == true:
		ShopOptions.visible = false
	else: 
		ShopOptions.visible = true


func _on_size_pressed():
	if money >= upgradecost[0]:
		money-=upgradecost[0]
		Size = cleannumber(Size*1.05)
		upgradecost[0]=cleannumber(1.2*upgradecost[0])
		updatemoney()
		SizeButton.text = str("Size: ",Size, "\n$",upgradecost[0], " : +5%")
	

func _on_damage_pressed():
	if money >= upgradecost[1]:
		money-=upgradecost[1]
		Damage = cleannumber(Damage *1.05)
		upgradecost[1]=cleannumber(1.2*upgradecost[1])
		updatemoney()
		DamageButton.text = str("Damage: ",Damage, "\n$",upgradecost[1], " : +5%")


func _on_idle_spin_speed_pressed():
	if money >= upgradecost[2]:
		money-=upgradecost[2]
		idleSpinSpeed=cleannumber(idleSpinSpeed+0.05)
		upgradecost[2]=cleannumber(1.2*upgradecost[2])
		updatemoney()
		IdleSpinSpeedbutton.text = str("IdleSpinSpeed: ",idleSpinSpeed, "\n$",upgradecost[2], " : +0.05")


func _on_spin_speed_pressed():
	if money >= upgradecost[3]:
		money-= upgradecost[3]
		SpinSpeed = cleannumber(SpinSpeed*1.05)
		upgradecost[3] = cleannumber(upgradecost[3]*1.2)
		updatemoney()
		SpinSpeedButton.text = str("ActiveSpinSpeed: ",SpinSpeed, "\n$",upgradecost[3], " : +5%")

func _on_grass_spawn_rate_pressed():
	if money >= upgradecost[4]:
		money-=upgradecost[4]
		grassSpawner.grassspawnrate = cleannumber(grassSpawner.grassspawnrate+1)
		upgradecost[4]=cleannumber(upgradecost[4]*1.2)
		updatemoney()
		GrassSpawnRateButton.text = str("GrassSpawnRate: ",1/grassSpawner.SpawnTime, "\n$",upgradecost[4], " : +1/s")

func _on_grass_health_pressed():
	if money >= upgradecost[5]:
		money-=upgradecost[5]
		grassSpawner.hp=cleannumber(grassSpawner.hp*1.05)
		upgradecost[5]=cleannumber(upgradecost[5]*1.20)
		updatemoney()
		GrassHealthButton.text = str("GrassHealth: ",grassSpawner.hp, "\n$",upgradecost[5], " : +5%")

func _on_blade_count_pressed():
	pass # Replace with function body.


func updatemoney():
	money=cleannumber(money)
	MoneyLabel.text = str("$",money)

func cleannumber(number):
	if number > 0.01 and number < 1000:
		number = floor(number*100)/100
	elif number > 1000:
		number = floor(number)
	else:
		number = floor(number*10000)/10000 
	return number

