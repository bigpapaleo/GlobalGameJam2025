//
//
//

uniform vec2 u_output_size;
uniform vec2 u_game_size;
uniform vec2 u_shift;
uniform float u_zoom;
uniform float u_do_int_scale;
uniform float u_aspect;
uniform float u_do_tate;
uniform float u_curvature_amount;
uniform float u_do_mask_mirror;
uniform float u_mask_strength;
uniform float u_mask_scale;
uniform float u_mask_tex_width;
uniform float u_mask_repeat_on_three;
uniform float u_mask_do_shadow;
uniform float u_slot_strength;
uniform float u_scanline_min;
uniform float u_scanline_bright_fade;
uniform float u_scanline_shape;
uniform float u_random_seed;
uniform float u_glow_spread;
uniform float u_glow_gamma;
uniform float u_glow_strength;
uniform float u_input_gamma;
uniform float u_output_gamma;
uniform float u_softness;
uniform float u_border_width;
uniform float u_border_brightness;
uniform float u_deconvergence;
uniform float u_noise_amount;
uniform float u_glow_over_mask;
uniform float u_post_brightness;

varying vec2 v_texcoord;

uniform sampler2D u_mask_sampler;
uniform sampler2D u_slot_sampler;

const float PHI = 1.61803398874989484820459;  // Φ = Golden Ratio

float gold_noise(vec2 xy, float seed) {
	/// Gold Noise ©2015 dcerisano@standard3d.com
	return fract(tan(distance(xy * PHI, xy) * seed) * xy.x);
}

vec4 get_input_color(sampler2D sampler, vec2 uv) {
	/// Fast version - only bilinear filtering is supported
	/// Also implements deconvergence
	
	vec2 p = uv;
	
	// Devonverge the RGB components
	vec2 texel = u_deconvergence / u_game_size;
    return vec4(texture2D( sampler, p + texel).r, texture2D( sampler, p).g, texture2D( sampler, p - texel).b, 1.0);
}


vec3 get_mask_color() {
	/// Gets the color of any phosphor overlapping the current fragment
	
	// Mirror the phosphor mask if required by the user
	float mirror = 1.0 - 2.0 * u_do_mask_mirror;
	
	// For the rgbx mask, the user can choose whether they want to drop the black column of pixels
	float repeat = 1.0 - (u_mask_repeat_on_three * 0.25);
	
	// Get from screen space to mask space
	vec2 num_triads = u_output_size / (u_mask_tex_width * u_mask_scale * repeat * mirror);
	vec2 mask_uv = mod(v_texcoord, 1.0 / num_triads) * num_triads * repeat;
	vec2 slot_uv = v_texcoord * u_output_size / vec2(u_mask_tex_width * 2.0 * repeat, 8.0) / u_mask_scale;
	
	// Convert to shadow mask (stagger) if desired
	mask_uv.x += (floor(mask_uv.y * 2.0 / repeat) / (2.0 * (1.0 + u_mask_repeat_on_three))) * u_mask_do_shadow;
	
	// Rotate the mask if in TATE mode
	mask_uv.xy = (u_do_tate > 0.5) ? mask_uv.yx : mask_uv.xy;
	slot_uv.xy = (u_do_tate > 0.5) ? slot_uv.yx : slot_uv.xy;
	
	// Sample the mask for a color
	vec3 mask_color = texture2D(u_mask_sampler, mask_uv).xyz;
	
	// Subtract the slot mask from the color if desired
	mask_color *= 1.0 - (texture2D(u_slot_sampler, slot_uv).xyz * u_slot_strength);
	
	// Mix between the reduced brightness mask and white, and return
	return mix(vec3(1.0), mask_color, u_mask_strength);
}

float get_scanlines(vec2 uv, float val) {
	/// Gets the brightness of the current fragment with respect to scanlines
	/// Multiplies the resulting brightness into the output
	
	// Construct a triangle wave, and raise it to a power to alter its shape
	vec2 wave = 1.0 - pow(abs(2.0 * mod(uv * u_game_size, 1.0) - 1.0), vec2(u_scanline_shape));
	
	// Scale the wave to raise the minimum brightness without altering the max brightness
	wave = clamp(u_scanline_min + (1.0 - u_scanline_min) * wave, 0.0, 1.0);
	
	// Get the luma that the current fragment should be
	float luma = wave.x * u_do_tate + wave.y * (1.0 - u_do_tate);
	
	luma = mix(luma, luma + (1.0 - luma) * smoothstep(0.0, 1.0, val), u_scanline_bright_fade);
	
	// Return the result
	return luma;
}

vec2 get_border_mask(vec2 p) {
    
	/// Returns a mask where 1.0 = outside the crt screen and 0.0 = inside
	
	// Calculate the width of the transition
	float width = max(1.0 / u_output_size.x, 1.0 / u_output_size.y) * 8.0;
    
	// Get the distance to the nearest edge of the crt
    float dist = min(
        min(p.x + width, width + 1.0 - p.x),
        min(p.y + width, width + 1.0 - p.y)
    );
    
	// Return a smooth mask and the distance to the nearest edge
    return vec2(1.0 - smoothstep(0.0, width, dist), -dist);
}

vec4 get_screen_geometry() {
	/// Handles scaling, aspect ratio, and curvature
	
	// Find the largest integer multiple of the game height that fits in the output height
	float nearest_int = (u_game_size.y * floor(u_output_size.y / u_game_size.y));
	
	// Calculate a scaling factor between the output vertical texcoord and the game's, using int scale if desired
    float vertical_scale = 1.0 + (u_do_int_scale * (-1.0 + u_output_size.y / nearest_int));
    
	// Calculate how much to stretch the game horizontally given the aspect ratios of the game and output
    float aspect = u_output_size.x / (u_output_size.y * u_aspect);
    
	// Integrate everything into the correct (albeit flat) uv coordinates
    vec2 uv = ((v_texcoord - 0.5) * vertical_scale * u_zoom) + 0.5;
    uv.x = ((uv.x - 0.5) * aspect) + 0.5;
    
	// Now, apply curvature via barrel distortion
	// First, the UVs are shifted such that they range from -0.5 to 0.5
    vec2 centered = uv - 0.5;
	
	// Calculate quadratic distance from {0.0, 0.0}
    float r = length(centered);
    float r2 = r * r;
    
	// Distort the UVs by multiplying them by the quadratic distance
    float distortion_factor = 1.0 + u_curvature_amount * r2;
    uv = centered * distortion_factor;
    
	// The previous operation shrunk the whole screen nonlinearly,
	// but now they can be scaled back up linearly so the net result is curved corners
    float scale_factor = 1.0 / (1.0 + u_curvature_amount * 0.25);
    uv *= scale_factor;
	
	// Shift the UVs back to the range 0.0 to 1.0
	uv += 0.5;
	
	// Shift the viewport to the user's preference
	uv += u_shift;
	
	// Get a mask to indicate whether the current fragment falls outside the crt
	vec2 border = get_border_mask(uv);
	
	// Wrap the UVs around the screen border, but flipped to simulate a reflection
	uv = -abs(1.0 - abs(uv)) + 1.0;
	
	// Skew the reflection for added realism
	uv = (uv - 0.5) / (1.0 + (border.x * border.y) * 1.0) + 0.5;
    
    // Finally, return the UVs and border flag
    return vec4(uv, border);
}

vec3 glow(vec2 uv, vec3 mask_color) {
	/// Applies a short-range bloom effect to bleed bright pixels into the surrounding area
	/// Should typically be applied after scanlines and the phosphor mask
	
	vec4 glow = vec4(0.0);

	// Simple one-pass blur using 4 samples
	// Save the size of a texel into a vec2
	vec2 texel = gold_noise(uv * 1000.0, u_random_seed) * u_glow_spread / u_game_size;
	vec2 h = texel * 0.6;
			
	// Accumulate samples from the surrounding texels
			
	// Fast version - only diagonals are sampled
	glow += texture2D( gm_BaseTexture, uv + vec2( -h.x, -h.y));
	glow += texture2D( gm_BaseTexture, uv + vec2( -h.x,  h.y));
	glow += texture2D( gm_BaseTexture, uv + vec2(  h.x, -h.y));
	glow += texture2D( gm_BaseTexture, uv + vec2(  h.x,  h.y));

	// Reduce the values back down to 0-1
	glow /= 4.0;
	
	// Add the result to the output
	vec3 result = pow(glow.xyz, vec3(u_glow_gamma)) * u_glow_strength;
	return mix(result * mask_color, result, u_glow_over_mask);
}

vec3 reflection(vec2 uv, float dist) {
	/// Applies a short-range bloom effect to bleed bright pixels into the surrounding area
	/// Should typically be applied after scanlines and the phosphor mask
	
	vec4 glow = vec4(0.0);

	// Simple one-pass blur using 4 samples
	// Save the size of a texel into a vec2
	vec2 texel = gold_noise(uv * 1000.0, u_random_seed) * pow(dist + 1.0, 2.0 * u_border_width) / u_game_size;
	vec2 h = texel * 1.0;
			
	// Accumulate samples from the surrounding texels
			
	// Fast version - only diagonals are sampled
	glow += texture2D( gm_BaseTexture, uv + vec2( -h.x, -h.y));
	glow += texture2D( gm_BaseTexture, uv + vec2( -h.x,  h.y));
	glow += texture2D( gm_BaseTexture, uv + vec2(  h.x, -h.y));
	glow += texture2D( gm_BaseTexture, uv + vec2(  h.x,  h.y));

	// Reduce the values back down to 0-1
	glow /= 4.0;
	
	// Add the result to the output
	return pow(glow.xyz, vec3(u_input_gamma)) * 1.0;
}

void main() {
	vec4 geom = get_screen_geometry();
	vec2 uv = geom.xy;
	float border_mask = geom.z;
	float border_dist = geom.w;
	
	vec3 color = get_input_color( gm_BaseTexture, uv).xyz;
	
	color += (gold_noise(floor(uv * vec2(640.0, 480.0)) + 0.1, u_random_seed) - 0.5) * u_noise_amount;
	
	color = pow(color, vec3(u_input_gamma));
	
	float val = max(max(color.r, color.g), color.b);
	
	float scan_luma = get_scanlines(uv, val);
	
	color *= mix(scan_luma, u_border_brightness * 0.5, border_mask);
	

	if (border_mask > 0.0) {
		color = mix(color, reflection(uv, border_dist), border_mask);
	}
	
	vec3 mask_color = get_mask_color();
	color *= mix(mask_color, vec3(u_border_brightness * 0.5), border_mask);
	
	if (border_mask < 1.0) {
		color += glow(uv, mask_color) * (1.0 - border_mask) * scan_luma;
	}
	
	color = mix(color, vec3(0.0), max(border_mask * border_dist, 0.0) * u_border_width);
	
	color *= u_post_brightness;
	
	color = pow(color, vec3(1.0 / u_output_gamma));
	
	float alpha = (border_mask > 0.9) ? step(0.01, 1.0 - max(border_mask * border_dist, 0.0) * u_border_width) : 1.0;
	
    gl_FragColor = vec4(color, alpha);
}
