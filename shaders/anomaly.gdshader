shader_type canvas_item;
uniform float offset;
void fragment() {
	vec4 color=vec4(0,0,0,0);
	vec4 initColor=texture(TEXTURE,UV);
	
	if (initColor.a!=0.0 && sqrt(((UV.x-0.5)*(UV.x-0.5))+((UV.y-0.5)*(UV.y-0.5)))<=0.3 &&
	 sqrt(((UV.x-0.5)*(UV.x-0.5))+((UV.y-0.5)*(UV.y-0.5)))>=0.29 && UV.x>=abs(sin((TIME+offset)*0.2)/1.2) && UV.x<=abs(sin((TIME+offset)*0.2)/1.1))
		color=vec4(1,1,1,0.5);
	COLOR=color;
}
