shader_type sky;

uniform vec3 skyColor = vec3(0.4, 0.6, 1.0);     // bluish zenith
uniform vec3 horizonColor = vec3(1.0, 0.9, 0.7); // warm horizon

void sky() {
    // y ranges from -1 (down) to +1 (up)
    float y = EYEDIR.y;

    // map [-1,1] -> [0,1]
    float t = clamp(y * 0.5 + 0.5, 0.0, 1.0);

    // blend colors
    vec3 finalColor = mix(horizonColor, skyColor, t);

    COLOR.rgb = finalColor; // assign to sky color
}
