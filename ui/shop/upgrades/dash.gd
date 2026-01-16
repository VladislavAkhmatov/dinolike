extends Control

@onready var upgrade_btn = $VBoxContainer/UpgradeBtn
@onready var upgrade_label = $VBoxContainer/Upgraded
@onready var click = $Click

var price = 400

func _ready():
	update_ui()

func _process(delta):
	upgrade_btn.disabled = Globals.points < price or Globals.dash == true
	if Globals.dash:
		upgrade_label.text = str(tr("PURCHASED"))
	
func update_ui():
	upgrade_label.text = str(tr("PRICE"), ": ", price, " ", tr("POINTS"))

func _on_upgrade_btn_pressed():
	if Globals.points >= price:
		click.play()
		click.finished
		Globals.points -= price
		Globals.dash = true
		update_ui()
