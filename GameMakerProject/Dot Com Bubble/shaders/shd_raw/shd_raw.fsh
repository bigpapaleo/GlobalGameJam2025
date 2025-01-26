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

vec4 get_input_color(sampler2D sampler, vec2 uv) {
	/// An alteration to bilinear filtering that pushes fragment UVs closer to their nearest point
	/// Results in more visual clarity than bilinear, with smoothed pixel edges and uniform centers
	/// Also implements deconvergence

	// Transform the UV out of texture space (0-1) and into world space (e.g., 0-320)
    vec2 p = uv * u_game_size + 0.5;

	// Split UV into fractional and integer components
    vec2 i = floor( p);
    vec2 f = p - i;
	
	// Magic math
    f = f * f * f * ( f * ( f * 6.0 - 15.0) + 10.0);
	
	// Recombine fractional and integer components
    p = i + f;
	
	// Transform the UV back into texture space
    p = ( p - 0.5) / u_game_size;
	
	// Allow the user to lerp between bilinear and quintic UVs
	p = mix(p, uv, u_softness);
	
	// Devonverge the RGB components
	vec2 texel = u_deconvergence / u_game_size;
    return texture2D( sampler, p);
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




void main() {
	vec4 geom = get_screen_geometry();
	vec2 uv = geom.xy;
	float border_mask = geom.z;
	float border_dist = geom.w;
	
	vec3 color = get_input_color( gm_BaseTexture, uv).xyz;
	
	color = pow(color, vec3(u_input_gamma));
	
	color = mix(color, vec3(0.0), border_mask) * 0.5;
	
	
	
	color = pow(color, vec3(1.0 / u_output_gamma));
	
    gl_FragColor = vec4(color, 1.0);
}
