extends Control

@onready var upgrade_btn = $VBoxContainer/UpgradeBtn
@onready var upgrade_label = $VBoxContainer/Upgraded
@onready var click = $Click

var max_lives = 3
var price_step = 200

func _ready():
	update_ui()

func _process(delta):
	var current_price = round((price_step * Globals.max_lives_step) / 1.1)
	upgrade_btn.disabled = Globals.points < current_price or Globals.max_lives >= max_lives
	if Globals.max_lives >= max_lives:
		upgrade_label.text = str(tr("PURCHASED"))
	
func update_ui():
	var current_price = round((price_step * Globals.max_lives_step) / 1.1)
	upgrade_label.text = str(tr("PRICE"), ": ", current_price, " ", tr("POINTS"))
	
	upgrade_label.text += str("\n", tr("LIVE"), ": ", Globals.max_lives)
	
	if Globals.max_lives == max_lives:
		upgrade_btn.disabled = true

func _on_upgrade_btn_pressed():
	if Globals.max_lives < max_lives:
		click.play()
		click.finished
		var current_price = round((price_step * Globals.max_lives_step) / 1.1)
		Globals.points -= current_price
		Globals.max_lives += 1
		Globals.lives = Globals.max_lives
		Globals.max_lives_step += 1
		print(Globals.max_lives)
	update_ui()
