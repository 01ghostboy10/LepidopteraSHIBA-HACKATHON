shader_type sky;

uniform vec3 skyColor = vec3(0.4, 0.6, 1.0);     // bluish zenith
uniform vec3 horizonColor = vec3(1.0, 0.9, 0.7); // warm horizon

void sky() {
    // get vertical direction of camera ray
    float t = clamp(EYEDIR.y * 0.5 + 0.5, 0.0, 1.0);

    // blend horizon -> sky
    vec3 finalColor = mix(horizonColor, skyColor, t);

    COLOR = vec4(finalColor, 1.0);
}