shader_type spatial;
uniform float SIZE = 12.0;
uniform float UV_FACTOR = 1.0;
uniform sampler2D NOISE;

vec2 brickTile(vec2 _st, float _zoom){
    _st *= _zoom;
    _st.x += step(1., mod(_st.y,2.0)) * 0.5;
    return fract(_st);
}

float box(vec2 _st, vec2 _size){
    _size = vec2(0.5)-_size*0.5;
    vec2 uv = smoothstep(_size,_size+vec2(1e-4),_st);
    uv *= smoothstep(_size,_size+vec2(1e-4),vec2(1.0)-_st);
    return uv.x*uv.y;
}

void fragment() {
	vec2 st = UV.xy;
    vec3 color = vec3(.2, .1, .05);
	float ran = texture(NOISE, UV * UV_FACTOR).x;
	st = brickTile(st, SIZE);

    color += vec3(box(st,vec2(0.95)));

	
    ALBEDO = color * vec3(2., 1.5, 0.5) * vec3(ran*1.5);
	METALLIC = 0.9;
	ROUGHNESS = ran * .5 * color.r;
}