shader_type canvas_item;

uniform float corner_radius : hint_range(0, 50) = 2.0;
uniform float edge_softness : hint_range(0, 10) = 2.0;

void fragment() {
    // Get texture size and convert UV to pixel coordinates
    vec2 size = vec2(textureSize(TEXTURE, 0));
    vec2 pixel_pos = UV * size;

    // Calculate distance from each corner
    vec2 corner_distances = min(pixel_pos, min(size - pixel_pos, vec2(corner_radius)));
    float corner_dist = length(max(vec2(corner_radius) - corner_distances, vec2(0.0)));

    // Create a sharp transition with minimal softness
    float alpha = 1.0 - smoothstep(0.0, edge_softness, corner_dist - corner_radius);

    // Apply the original texture color with our custom alpha
    COLOR = texture(TEXTURE, UV);
    COLOR.a *= alpha;
}