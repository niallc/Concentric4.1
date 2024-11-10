shader_type canvas_item;

uniform float corner_radius : hint_range(0, 20) = 5.0;

void fragment() {
    vec2 size = vec2(textureSize(TEXTURE, 0));
    vec2 uv = UV * size;

    // Calculate distance from corners
    float dist = length(min(uv - corner_radius, vec2(0.0)));
    dist = min(dist, length(min(vec2(size.x - uv.x, uv.y) - corner_radius, vec2(0.0))));
    dist = min(dist, length(min(vec2(uv.x, size.y - uv.y) - corner_radius, vec2(0.0))));
    dist = min(dist, length(min(vec2(size.x - uv.x, size.y - uv.y) - corner_radius, vec2(0.0))));

    // Apply rounded corners
    float alpha = 1.0 - smoothstep(0.0, 1.0, dist / corner_radius);
    COLOR.a *= alpha;
}