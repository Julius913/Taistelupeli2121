tool
extends TextureButton

export(String) var text = "Text button"
export(int) var arrow_margin_from_center = 100



func _ready():
	setup_text()
	show_arrows()
	set_focus_mode(true)

# warning-ignore:unused_argument
func _process(delta):
	if Engine.editor_hint:
		setup_text()
		show_arrows()

func setup_text():
	$RichTextLabel.bbcode_text = "[center] %s [/center]" % [text]
	
func show_arrows():
	for arrow in [$LeftArrow, $RightArrow]:
		arrow.visible = true
		arrow.global_position.y = rect_global_position.y + (rect_size.y / 2.0)


	var center_x = rect_global_position.x + (rect_size.x / 2) * 1.5
	$LeftArrow.global_position.x = center_x - arrow_margin_from_center
	$RightArrow.global_position.x = center_x + arrow_margin_from_center
