class_name EditExtras
extends Control

@export var tab_container: TabContainer
@export var anim_speed: float = 0.5

var _project: Project

func attach_project(project: Project):
	_project = project
	for node in tab_container.get_children():
		if node.has_method("attach_project"):
			node.attach_project(project)

## Opens the extras panel.
func open():
	if !visible:
		visible = true

		var top = get_viewport_rect().size.y
		position.y = top

		var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position:y", 0, anim_speed)

## Closes and hides the extras panel.
func close():
	if visible:
		var top = get_viewport_rect().size.y

		var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position:y", top, anim_speed)
		await tween.finished

		visible = false
