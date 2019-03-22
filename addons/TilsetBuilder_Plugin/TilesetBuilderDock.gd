tool
extends Panel
var editor_interface
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var items_list = null

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button_ADD").connect("pressed", self, "ADD_pressed")
	get_node("Button_DEL").connect("pressed", self, "DEL_pressed")
	self.items_list = get_node("ItemList")
	get_node("FileDialog_SAVE").connect("file_selected", self, "SAVE_file")
	get_node("FileDialog_OPEN_PNG").connect("file_selected", self, "OPEN_PNG_file")
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func ADD_pressed():
	print("select image ...")
	get_node("FileDialog_OPEN_PNG").popup_centered()
	
func DEL_pressed():
	pass
	
func SAVE_file():
	pass
	
func OPEN_PNG_file(path):
	var img = Image.new()
	img.load(path) 
	items_list.add_item(path,load(path))
	pass	
