shader_type canvas_item;

uniform float lod: hint_range(0.0, 5) = 0.0;
uniform sampler2D screen_texture;
uniform vec4 particle_color: source_color;

void fragment(){
	vec4 color = texture(screen_texture, UV, lod);
	COLOR = color * particle_color;
}