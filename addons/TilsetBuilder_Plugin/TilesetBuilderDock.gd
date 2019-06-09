tool
extends Control

var editor_interface
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var items_list = null
var selected_item_id = -1
var src_images = {}
var Builder = TilesetBuilder.new()

class TileItem:
	var width:int = 16
	var height:int = 16
	var name:String = "noname"
	var src:Image = null



func _ready():
	get_node("Button_ADD").connect("pressed", self, "ADD_pressed")
	get_node("Button_DEL").connect("pressed", self, "DEL_pressed")
	get_node("Button_CLEAR").connect("pressed", self, "CLEAR_pressed")
	get_node("Button_EXP").connect("pressed", self, "EXP_pressed")
	self.items_list = get_node("ItemList")
	get_node("ItemList").connect("item_selected",self,"SelectedItemId")
	get_node("FileDialog_SAVE").connect("file_selected", self, "SAVE_file")
	get_node("FileDialog_OPEN_PNG").connect("file_selected", self, "OPEN_PNG_file")
	
	pass 

func SelectedItemId(ID:int):
	self.selected_item_id = ID
	pass

func CLEAR_pressed():
	print("clear images ...")
	self.items_list.clear()
	pass
	
func ADD_pressed():
	print("select image ...")
	get_node("FileDialog_OPEN_PNG").popup_centered()
	
func EXP_pressed():
	get_node("FileDialog_SAVE").popup_centered()
	
func DEL_pressed():
	if (self.items_list.get_item_count()>0):
		if (self.selected_item_id>=0):
			self.items_list.remove_item(self.selected_item_id)
	
	
func SAVE_file(path):
	Builder.BuildFromImages(src_images,path)
	pass
	
func OPEN_PNG_file(path):
	
	var split_path = path.split("/")
	var filename = split_path[split_path.size()-1]
	var icon:Texture = load(path)
	items_list.add_item(filename,icon)
	
	var id = items_list.get_item_count()-1
	var src_item:TileItem = TileItem.new()
	src_item.width = int(get_node("LineEdit_w").text)
	src_item.height = int(get_node("LineEdit_h").text)
	src_item.name = filename
	
	src_item.src = Image.new()
	src_item.src = icon.get_data()
	src_item.src.set_name(filename)
	
	src_images[String(id)] = src_item
	
	pass	
