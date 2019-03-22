tool
extends EditorPlugin

var io_tileset_dialog

func _enter_tree():
	io_tileset_dialog = preload("res://addons/TilsetBuilder_Plugin/TilesetBuilderDock.tscn").instance()
	#io_tileset_dialog.editor_interface = get_editor_interface()
	add_control_to_dock(DOCK_SLOT_LEFT_UL, io_tileset_dialog)

func _exit_tree():
	remove_control_from_docks(io_tileset_dialog)
