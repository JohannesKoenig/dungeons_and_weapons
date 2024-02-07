shader_type canvas_item;

uniform vec2 direction = vec2(1, 0);
uniform float speed = 0.1;
uniform sampler2D noise: repeat_enable, filter_linear;

vec4 overlay(vec4 base, vec4 blend){
	vec4 limit = step(0.5, base);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}

void fragment()
{
	// image texture
	vec4 base = texture(TEXTURE, UV);
	// noise texture
	vec4 blend = texture(noise, UV + ( direction * speed * TIME));
	blend.a = blend.r;
	blend.a = blend.a * 0.7;
	COLOR = blend;
}