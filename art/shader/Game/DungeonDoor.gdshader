shader_type canvas_item;

// noise texture
uniform sampler2D noise_texture: repeat_enable;
uniform vec2 scroll;
uniform vec2 center;
uniform float strength;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float distortion_strength: hint_range(-1,1) = 0.1;
uniform vec4 color: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 noise_color = texture(noise_texture, UV + scroll * TIME);
	 // Calculate the distance to the center of the image
    float dist = distance(UV, center);
    noise_color.a = min(noise_color.r, 1.0 - dist * strength);
	// Combine the noise color and the gradient
    COLOR = noise_color * color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
