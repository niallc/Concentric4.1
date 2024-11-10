shader_type canvas_item;

uniform float border_width : hint_range(0, 50) = 4.0;
uniform float corner_radius : hint_range(0, 150) = 120.0;
uniform vec4 border_color : source_color = vec4(0.8, 0.8, 0.8, 0.3);

void fragment() {
    // Get size and position
    vec2 size = vec2(textureSize(TEXTURE, 0));
    vec2 pixel_pos = UV * size;

    // Calculate distance from edges
    vec2 border_dist = min(pixel_pos, size - pixel_pos);

    // Calculate distance from corners similar to card shader
    vec2 corner_distances = min(pixel_pos, min(size - pixel_pos, vec2(corner_radius)));
    float corner_dist = length(max(vec2(corner_radius) - corner_distances, vec2(0.0)));

    // Combine border and corner checks
    float dist_from_edge = min(min(border_dist.x, border_dist.y), corner_radius - corner_dist);

    // Create border effect
    float border_alpha = smoothstep(0.0, 2.0, dist_from_edge) - smoothstep(border_width - 2.0, border_width, dist_from_edge);

    // Output final color
    COLOR = border_color;
    COLOR.a *= border_alpha;
}