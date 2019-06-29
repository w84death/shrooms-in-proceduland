shader_type spatial;

uniform float WAVE_SCALE = 0.05;
uniform float WAVE_SPEED_FACTOR = 4.0;

uniform int OCTAVES = 6;

float random (in vec2 st) {
    return fract(sin(dot(st.xy,vec2(12.9898,78.233)))*43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float fbm (vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitude = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(st);
        st *= 2.;
        amplitude *= .5;
    }
    return value;
}
void vertex() {
	float waves = fbm(VERTEX.xz * .2  + TIME * WAVE_SPEED_FACTOR) * WAVE_SCALE;
	VERTEX.y = waves;
}

void fragment() {
	vec3 alb = vec3(.1, .3, .45);
	
	ALPHA = 0.8;
	SPECULAR = 1.;
	ROUGHNESS = .3;
	METALLIC = 0.4;
	ALBEDO = alb;
}