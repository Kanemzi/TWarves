shader_type canvas_item;

uniform vec4 base_skin : hint_color = vec4(0.667, 0.667, 0.667, 1.0);
uniform vec4 base_chest : hint_color = vec4(0.733, 0.733, 0.733, 1.0);
uniform vec4 base_pants : hint_color = vec4(0.8, 0.8, 0.8, 1.0);
uniform vec4 base_boots : hint_color = vec4(0.867, 0.867, 0.867, 1.0);

uniform vec4 skin:hint_color;
uniform vec4 chest:hint_color;
uniform vec4 pants:hint_color;
uniform vec4 boots:hint_color;

void fragment() {
	vec4 c = texture(TEXTURE, UV);

	if (c == base_skin)
		COLOR = skin;
	else if (c == base_chest)
		COLOR = chest;
	else if (c == base_pants)
		COLOR = pants;
	else if (c == base_boots)
		COLOR = boots;
	else
		COLOR = c;
}