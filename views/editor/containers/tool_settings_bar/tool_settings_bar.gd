extends Panel

@export var margin_container: MarginContainer

var current_tool: Tool
var tool_settings_bar: Control


func _on_editor_tool_changed(tool: Tool) -> void:
	if tool_settings_bar:
		tool_settings_bar.queue_free()

	current_tool = tool
	if current_tool.handler_bar:
		var bar = current_tool.handler_bar.instantiate()
		bar.name = "ToolSettingsBar"
		bar.tool = current_tool
		tool.connect("settings_changed", Callable(bar, "_on_tool_settings_changed"))
		margin_container.add_child(bar)
		tool_settings_bar = bar
