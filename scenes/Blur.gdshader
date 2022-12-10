shader_type canvas_item;

uniform float lod: hint_range(0, 6) = 2;

void fragment(){
	
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, lod);
	COLOR = color;
	

}