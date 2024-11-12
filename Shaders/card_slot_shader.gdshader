shader_type canvas_item;

uniform float border_width : hint_range(0.0, 1.0) = 0.1;
uniform float max_alpha: hint_range(0, 1) = 0.8;
uniform float texture_overlap: hint_range(0.0, 1.0) = 0.03;
uniform vec2 disc_offset = vec2(0.25, 0.25);

//float scaled_distance(float a, float b, float scale) {
	//return abs(a - b) / scale;
//}
//
//float min_zero_scaled_dist(float a, float b, float scale) {
	//return max(scaled_distance(a, b, scale), 0.);
//}

void fragment() {
	float total_border_width = border_width + texture_overlap;

	//float alpha_left = min_zero_scaled_dist(UV.x, 1., border_width);

	//float alpha_left = max((border_width - UV.x) / border_width, 0.);
	float alpha_left = max((total_border_width - UV.x) / border_width, 0.);

	float alpha_right = max((UV.x - 1. + total_border_width) / border_width, 0.);
	float alpha_bottom = max((total_border_width - UV.y) / border_width, 0.);
	float alpha_top = max((UV.y - 1. + total_border_width) / border_width, 0.);

	float alpha = alpha_left + alpha_right +
	              alpha_top + alpha_bottom;

	COLOR.a = min(alpha, max_alpha);
    //COLOR = tex_color;
}
