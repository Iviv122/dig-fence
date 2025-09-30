shader_type canvas_item;
render_mode blend_mix;

uniform vec4 color : source_color;
uniform vec2 size = vec2(1280.0, 720.0);
uniform float line_width : hint_range(0, 1) = 0.1;
uniform vec2 offset = vec2(0.0, 0.0);
uniform float grid_size = 16.0;
uniform float speed = 1;

void fragment() {
	vec2 uv = (offset+TIME*speed / size) + UV;
	vec2 r = mod(size * uv, vec2(grid_size));
	vec2 lines = smoothstep(1.0 - line_width, 1, r / vec2(grid_size));
	float alpha = dot(lines, vec2(1.0, 1.0));
	COLOR.rgb = color.rgb; 
	COLOR.a = alpha*color.a;
}