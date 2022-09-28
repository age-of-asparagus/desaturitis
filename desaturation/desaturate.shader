shader_type canvas_item;

uniform float fade : hint_range(0.0, 1.0);
uniform sampler2D mask : hint_albedo;

void fragment() {
	 
	float value = texture(mask, UV).r;
	
	COLOR.rgb = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	float gray =  (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	COLOR.rgb = vec3(gray);
	
//	float alpha = step(value, fade);
	float alpha = step(value, fade);
	
	// fade the color out (via animated alpha) from the center
		
	COLOR.a = texture(TEXTURE, UV).a * alpha * fade;
}




//	float alpha = texture(TEXTURE, UV).a;  
////	float value = texture(mask, UV).r;
////	if (value < fade) {
//		COLOR.rgb = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
//		float gray =  (COLOR.r + COLOR.g + COLOR.b) / 3.0;
//		COLOR.rgb = vec3(gray);
//
//		// fade the color out (via animated alpha) from the center
//
//		COLOR.a = alpha * fade;