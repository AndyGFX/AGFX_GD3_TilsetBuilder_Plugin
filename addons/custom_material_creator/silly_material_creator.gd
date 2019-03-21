tool
extends Panel

var silly_material_resource = preload("res://addons/custom_material_creator/silly_material_resource.gd")
var editor_interface

func _ready():
	# Connect all of the signals we'll need to save and load silly materials
	get_node("Button_save").connect("pressed", self, "save_pressed")
	get_node("Button_load").connect("pressed", self, "load_pressed")
	get_node("Save_FileDialog").connect("file_selected", self, "save_file_selected")
	get_node("Load_FileDialog").connect("file_selected", self, "load_file_selected")


func save_pressed():
	get_node("Save_FileDialog").popup_centered()

func load_pressed():
	get_node("Load_FileDialog").popup_centered()


func save_file_selected(path):
	# Get the values from the sliders and color picker
	var color = get_node("ColorPicker_albedo").color
	var metallic = get_node("HSlider_metallic").value
	var roughness = get_node("HSlider_roughness").value
	
	# Make a new silly resource (which in this case actually is a node)
	# and initialize it
	var silly_resource = silly_material_resource.new()
	silly_resource.init()
	
	# Assign the values
	silly_resource.albedo_color = color
	silly_resource.metallic_strength = metallic
	silly_resource.roughness_strength = roughness
	
	# Make a file, store the silly material as a json string, then close the file.
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(silly_resource.make_json())
	file.close()
	
	return true


func load_file_selected(path):
	# Using the passed in editor interface, get the selected nodes in the editor
	var editor_selection = editor_interface.get_selection()
	var selected_nodes = editor_selection.get_selected_nodes()
	
	var file = File.new()
	var SpatialMaterial_Silly = null
	
	# Make a new silly resource (which in this case actually is a node)
	# and initialize it
	var silly_resource = silly_material_resource.new()
	silly_resource.init()
	
	# If the file exists, then open it
	if file.file_exists(path):
		file.open(path, File.READ)
		
		# Get the JSON string and convert it into a silly material.
		var json_dict_as_string = file.get_line()
		if json_dict_as_string != null:
			silly_resource.from_json(json_dict_as_string)
		else:
			file.close()
			return false
		
		# Tell the silly resource (actually a node) to make a material
		SpatialMaterial_Silly = silly_resource.make_material()
		
		# Go through the selected nodes and see if they have the 'set_surface_material'
		# function (which only MeshInstance has by default). If they do, then set the material
		# to the silly material.
		for node in selected_nodes:
			if node.has_method("set_surface_material"):
				node.set_surface_material(0, SpatialMaterial_Silly)
		
		# Close the file and return true (success!)
		file.close()
		return true
	
	# If the file does not exist, then return false (failure)
	else:
		return false
	
	# If we somehow get here, then return false (failure)
	return false
