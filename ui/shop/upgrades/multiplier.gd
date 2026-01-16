extends Control

@onready var upgrade_btn = $VBoxContainer/UpgradeBtn
@onready var upgrade_label = $VBoxContainer/Upgraded
@onready var click = $Click

var price_step = 20

func _ready():
	update_ui()

func _process(delta):
	var current_price = price_step * Globals.multiplier_step
	upgrade_btn.disabled = Globals.points < current_price
		
func update_ui():
	var current_price = price_step * Globals.multiplier_step
	upgrade_label.text = str(tr("PRICE"), ": ", current_price, " ", tr("POINTS"))
	
	upgrade_label.text += str("\nMultiplier x: ", Globals.multiplier)
	
func _on_upgrade_btn_pressed():
	click.play()
	click.finished
	var current_price = price_step * Globals.multiplier_step
	Globals.points -= current_price
	Globals.multiplier += 0.2
	Globals.multiplier_step += 1
	update_ui()
