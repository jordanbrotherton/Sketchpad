extends PanelContainer

@export var tool: Dragger
var tool_manager: ToolManager

func assign_tool(new_tool: Tool) -> void:
    self.tool = new_tool
