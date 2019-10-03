shader_type spatial;

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
    vec3 color = vec3(0.0);
	st = brickTile(st, 12.0);

    color = vec3(box(st,vec2(0.9)));

    ALBEDO = color;
}