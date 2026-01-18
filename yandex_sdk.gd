extends Node

var _ready_ok := false
var _busy := false

func _ready():
	if OS.has_feature("web"):
		call_deferred("_wait_sdk")
		
func _wait_sdk() -> void:
	while true:
		var ready = JavaScriptBridge.eval("window.YG_READY === true", true)
		if ready:
			_ready_ok = true
			print("sdk ready")
			apply_platform_language()
			return
		await get_tree().process_frame

func show_ad_after_death() -> void:
	if !_ready_ok or _busy:
		return
	_busy = true
	JavaScriptBridge.eval("window.YG.showInterstitial()", true)
	_busy = false

func get_lang() -> String:
	if !OS.has_feature("web"):
		return "ru"
	var lang = JavaScriptBridge.eval("window.YG.getLang()", true)
	return str(lang)
	
func apply_platform_language() -> void:
	var lang := get_lang()
	TranslationServer.set_locale(lang)
	
func set_locale(locale: String):
	TranslationServer.set_locale(locale)
