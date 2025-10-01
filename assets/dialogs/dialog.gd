extends VBoxContainer
class_name Dialog

@export var dialogue_gdscript : GDScript = null
var dialogue_engine : DialogueEngine = null

@export var scene : PackedScene 

func _ready() -> void:
	add_theme_constant_override("separation",15)


	dialogue_engine = dialogue_gdscript.new()
	dialogue_engine.dialogue_started.connect(__on_dialogue_started)
	dialogue_engine.dialogue_continued.connect(__on_dialogue_continued)
	dialogue_engine.dialogue_finished.connect(__on_dialogue_finished)


var listen = true
func _input(p_input_event : InputEvent) -> void:
	if p_input_event.is_action_pressed(&"ui_accept") && listen:
		dialogue_engine.advance()


func __on_dialogue_started() -> void:
	print("Dialogue Started!")


func __on_dialogue_continued(p_dialogue_entry : DialogueEntry) -> void:
	var label : RichTextLabel = RichTextLabel.new()
	label.set_use_bbcode(true)
	label.set_fit_content(true)

	var character_name = p_dialogue_entry.get_metadata("name") 
	label.set_text(character_name + "  > " + p_dialogue_entry.get_text() + "\n")
	add_child(label)


func __on_dialogue_finished() -> void:
	print("Dialogue Finished! Exiting...")
	get_tree().change_scene_to_packed(scene)
	listen = false