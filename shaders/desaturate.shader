shader_type canvas_item;

uniform vec4 tint;

//void vertex() {
//	VERTEX.x += cos(TIME)*20.0;
//	VERTEX.y += sin(TIME)*20.0;
//}

void fragment() {

	float alpha = texture(TEXTURE, UV).a;  
	COLOR.rgb = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	float gray =  (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	COLOR.rgb = vec3(gray);
	COLOR.a = alpha;
}