shader_type canvas_item;

uniform float border_width : hint_range(0.0, 1.0) = 0.1;
uniform float max_alpha: hint_range(0, 1) = 0.5;
uniform float texture_overlap: hint_range(0.0, 1.0) = 0.03;
uniform vec2 disc_offset = vec2(0.1, 0.1);

void fragment() {
	float disc_radius = disc_offset.x;
	float total_border_width = border_width + texture_overlap;

	// Calculate opacity of border additions from 1-d edge distances
	float alpha_left = max((total_border_width - UV.x) / border_width, 0.);
	float alpha_right = max((UV.x - 1. + total_border_width) / border_width, 0.);
	float alpha_bottom = max((total_border_width - UV.y) / border_width, 0.);
	float alpha_top = max((UV.y - 1. + total_border_width) / border_width, 0.);

	float edge_alpha = alpha_left + alpha_right +
	                   alpha_top + alpha_bottom;

	// Calculate overwriting transparency of border from radius
	// First use transparency to round the top left corner.
	vec2 TL_center = disc_offset;
	float TL_radial_alpha = 1.;
	bool distance_check_top_left = length(UV - TL_center) > disc_radius;
	bool quadrant_check_top_left = UV.x < disc_offset.x && UV.y < disc_offset.y;
	if (distance_check_top_left && quadrant_check_top_left) {
		TL_radial_alpha = 0.;
	}

	// Next use transparency to round the bottom left corner.
	vec2 BL_center = vec2(disc_offset.x, 1. - disc_offset.y);
	float BL_radial_alpha = 1.;
	bool distance_check_bottom_left = length(UV - BL_center) > disc_radius;
	bool quadrant_check_bottom_left = UV.x < disc_offset.x && UV.y > (1. - disc_offset.y);
	if (distance_check_bottom_left && quadrant_check_bottom_left) {
		BL_radial_alpha = 0.;
	}

	// Next use transparency to round the bottom right corner.
	vec2 TR_center = vec2(1. - disc_offset.x, disc_offset.y);
	float TR_radial_alpha = 1.;
	bool distance_check_top_right = length(UV - TR_center) > disc_radius;
	bool quadrant_check_top_right = (UV.x > (1. - disc_offset.x)) && UV.y < disc_offset.y;
	if (distance_check_top_right && quadrant_check_top_right) {
		TR_radial_alpha = 0.;
	}

	// Next use transparency to round the bottom left corner.
	vec2 BR_center = vec2(1. - disc_offset.x, 1. - disc_offset.y);
	float BR_radial_alpha = 1.;
	bool distance_check_bottom_right = length(UV - BR_center) > disc_radius;
	bool quadrant_check_bottom_right = UV.x > (1. - disc_offset.x) && UV.y > (1. - disc_offset.y);
	if (distance_check_bottom_right && quadrant_check_bottom_right) {
		BR_radial_alpha = 0.;
	}

	float radial_alpha = TL_radial_alpha * BL_radial_alpha *
						 TR_radial_alpha * BR_radial_alpha;
	radial_alpha *= max_alpha;
	float alpha = edge_alpha * radial_alpha;

	COLOR.a = min(alpha, max_alpha);
}
