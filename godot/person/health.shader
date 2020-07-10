shader_type canvas_item;

uniform float health;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	if (tex.a == 0.0) {
		return;
	}
	vec4 healthy = vec4(0.0, 1.0, 0.0, 1.0);
	vec4 unhealthy = vec4(1.0, 0.0, 0.0, 1.0);
	float factor = health / 100.0;
	tex.r = mix(unhealthy.r, healthy.r, factor);
	tex.g = mix(unhealthy.g, healthy.g, factor);
	tex.b = mix(unhealthy.b, healthy.b, factor);
	COLOR = tex;
}
