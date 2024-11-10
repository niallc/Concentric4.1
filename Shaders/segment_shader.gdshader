shader_type canvas_item;

// Radius of rounded corners in pixels
uniform float corner_radius : hint_range(0, 20) = 5.0;

void fragment() {
    // Get the size of the texture in pixels
    vec2 size = vec2(textureSize(TEXTURE, 0));

    // UV coordinates are normalized (0-1). Convert to pixel coordinates
    vec2 pixel_pos = UV * size;

    // Calculate distances from each corner
    float top_left = length(max(corner_radius - pixel_pos, 0.0));
    float top_right = length(max(corner_radius - vec2(size.x - pixel_pos.x, pixel_pos.y), 0.0));
    float bottom_left = length(max(corner_radius - vec2(pixel_pos.x, size.y - pixel_pos.y), 0.0));
    float bottom_right = length(max(corner_radius - vec2(size.x - pixel_pos.x, size.y - pixel_pos.y), 0.0));

    // Take the minimum distance to determine which corner we're closest to
    float corner_dist = min(min(top_left, top_right), min(bottom_left, bottom_right));

    // Create smooth transition at corners
    // float alpha = 1.0 - smoothstep(0.0, corner_radius, corner_dist);
    float alpha = smoothstep(0.0, corner_radius, corner_dist);

    // Preserve the original color but modify alpha for transparency at corners
    COLOR.a *= alpha;
}