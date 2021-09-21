extends Control

onready var viewport_container = $ViewportContainer
onready var viewport = $ViewportContainer/Viewport
onready var texture_rect = $ViewportContainer/Viewport/TextureRect

const GOL_SIZE = 128


func _ready():
	# The trick is to plug in the output of the shader as it's input ;)
	# That way each iteration works on the results of the previous one
	texture_rect.material.set_shader_param('gol', viewport.get_texture());
	_on_GoLGodot_resized()


func _on_GoLGodot_resized():
	if viewport_container == null:
		return
	var size = self.rect_size
	var min_size = min(size.x, size.y)
	var scale = min_size / GOL_SIZE
	viewport_container.rect_scale = Vector2(scale, scale)


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			var img = viewport.get_texture().get_data()
			var tex = ImageTexture.new()
			tex.create_from_image(img)
			texture_rect.material.set_shader_param('gol', tex)
		elif event.button_index == BUTTON_RIGHT:
			texture_rect.material.set_shader_param(
				'gol', viewport.get_texture()
			);
