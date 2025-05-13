shader_type canvas_item;

// Wave parameters (amplitude is relative to screen height)
uniform float amplitude : hint_range(0.0, 0.5) = 0.1;
uniform float frequency : hint_range(0.0, 10.0) = 2.0;
uniform float sine_speed : hint_range(0.0, 10.0) = 1.0;
uniform float cosine_speed : hint_range(0.0, 10.0) = 1.5;
uniform float tangent_speed : hint_range(0.0, 10.0) = 0.5;

// Wave colors
uniform vec4 sine_wave_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 cosine_wave_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 tangent_wave_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

// Background color and grid
uniform vec4 background_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

// Line thickness (in normalized screen units)
const float line_width = 0.005;
const float grid_line_width = 0.002;

// Function to get a slightly darker version of the background color for the grid
vec4 get_grid_color() {
    // Reduce the brightness of the background color for subtle grid lines
    return vec4(background_color.rgb * 2.5, 1.0);
}

void fragment() {
    // SCREEN_UV provides normalized screen coordinates (0 to 1)
    vec2 uv = SCREEN_UV;

    // Calculate sine, cosine, and tangent waves with different speeds
    float sine_value = sin(uv.x * 2.0 * 3.14159 * frequency + TIME * sine_speed);
    float cosine_value = cos(uv.x * 2.0 * 3.14159 * frequency + TIME * cosine_speed);
    float tangent_value = tan(uv.x * 2.0 * 3.14159 * frequency + TIME * tangent_speed);

    // Offset the sine, cosine, and tangent waves so that their midlines are at 0.5
    // and scale them by the amplitude.
    float sine_wave_y = 0.5 + sine_value * amplitude;
    float cosine_wave_y = 0.5 + cosine_value * amplitude;
    float tangent_wave_y = 0.5 + tangent_value * amplitude;

    // Check if the pixel is close to one of the waves
    float sine_diff = abs(uv.y - sine_wave_y);
    float cosine_diff = abs(uv.y - cosine_wave_y);
    float tangent_diff = abs(uv.y - tangent_wave_y);

    // Set color for sine wave
    if (sine_diff < line_width) {
        COLOR = sine_wave_color;
    }
    // Set color for cosine wave (below sine wave)
    else if (cosine_diff < line_width) {
        COLOR = cosine_wave_color;
    }
    // Set color for tangent wave (above sine wave)
    else if (tangent_diff < line_width) {
        COLOR = tangent_wave_color;
    }
    // If it's not near any wave, draw the grid or the background
    else {
        // Create a grid with horizontal and vertical lines
        if (mod(uv.x, 0.05) < grid_line_width || mod(uv.y, 0.05) < grid_line_width) {
            COLOR = get_grid_color(); // Subtle grid color
        }
        else {
            COLOR = background_color; // Background color
        }
    }
}
