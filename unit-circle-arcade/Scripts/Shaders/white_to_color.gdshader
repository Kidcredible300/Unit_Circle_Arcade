shader_type canvas_item;

// Color to replace white with (editable in Inspector)
uniform vec4 replacement_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Default: Yellow
uniform float threshold : hint_range(0.0, 1.0) = 0.9; // Sensitivity for detecting white

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    
    // Compute intensity to detect white areas
    float intensity = (color.r + color.g + color.b) / 3.0;

    if (intensity > threshold) {
        COLOR = vec4(replacement_color.rgb, color.a); // Replace white with the chosen color
    } else {
        COLOR = color; // Keep original color
    }
}
