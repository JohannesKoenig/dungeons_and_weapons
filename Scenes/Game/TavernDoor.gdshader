shader_type canvas_item;

uniform sampler2D diffuse: filter_nearest_mipmap;
uniform sampler2D normal;


void fragment() {
	vec4 color = texture(diffuse, UV);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
