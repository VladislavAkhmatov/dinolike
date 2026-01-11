extends Control

@onready var upgrade_btn = $VBoxContainer/UpgradeBtn

func _ready():
		if Globals.multiplier >= 9.9:
			upgrade_btn.disabled = true

func _on_upgrade_btn_pressed():
	if Globals.multiplier < 9.9:
		Globals.multiplier += 0.2
		print(Globals.multiplier)
	else:
		upgrade_btn.disabled = true
