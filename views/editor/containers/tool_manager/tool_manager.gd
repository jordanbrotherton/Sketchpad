class_name ToolManager
extends Control

@export var tool_tab: TabContainer
@export var editor: Editor

var toolviews: Dictionary[Tool, Node] = {}
var _project: Project


func _ready() -> void:
	for tool in editor.toolset.tools:
		var tool_control = tool.handler.instantiate()
		tool_control.tool = tool
		tool_control.tool_manager = self
		tool_tab.add_child(tool_control)
		tool.connect("settings_changed", Callable(tool_control, "_on_tool_settings_changed"))
		tool_control.assign_tool(tool)
		tool_tab.set_tab_title(tool_tab.get_child_count() - 1, tool.name)
		tool_tab.set_tab_icon(tool_tab.get_child_count() - 1, tool.icon)
		toolviews[tool] = tool_control
	_on_tool_list_tab_changed(0)
	editor.connect("tool_changed", Callable(self, "_on_tool_changed"))


func attach_project(project: Project) -> void:
	_project = project


func _on_tool_list_tab_changed(tab: int) -> void:
	editor.current_tool = tool_tab.get_tab_control(tab).tool

func _on_tool_changed(tool: Tool) -> void:
	var index = editor.toolset.tools.find(tool)
	tool_tab.current_tab = index
