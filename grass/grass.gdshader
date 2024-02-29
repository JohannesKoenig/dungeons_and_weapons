shader_type canvas_item;

uniform float speed;
uniform float amplitude;
uniform sampler2D noise;
uniform vec2 global_position;
uniform vec2 top_l;
uniform vec2 bottom_r;

void vertex() {
	vec2 normalized = (global_position - top_l) / (bottom_r - top_l);
	vec4 global_noise_tex = texture(noise, normalized);
	vec4 noise_tex = texture(noise, UV);
	float speed_var = speed * global_noise_tex.r;
	float amplitude_var = amplitude * noise_tex.r * global_noise_tex.r;
	VERTEX.x += sin(TIME* speed_var) * amplitude * (1.0-UV.y);
	//COLOR = vec4(normalized, 0.0, 1.0);
}

void fragment() {
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
