/// @description Initialization

if output_width < 0 {
	output_width = window_get_width();
}

if output_height < 0 {
	output_height = window_get_height();
}

resize_surfaces = function() {
	my_game_surface = surface_create(1920, 1080);
	camera_set_view_pos(view_get_camera(0), 800, 0);
	camera_set_view_size(view_get_camera(0), 1920, 1080);
	view_set_surface_id(0, my_game_surface);
	
	monitor_surface = surface_create(game_width, game_height);
	camera_set_view_pos(view_get_camera(1), -60, 0);
	camera_set_view_size(view_get_camera(1), 975, game_height);
	view_set_surface_id(1, monitor_surface);

	application_surface_draw_enable(false);

	// display_set_gui_size(output_width, output_height);
}

resize_surfaces();

update_uniforms = function() {
	shader_set_uniform_f(shader_get_uniform(shader, "u_output_size"), output_width, output_height);
	shader_set_uniform_f(shader_get_uniform(shader, "u_game_size"), game_width, game_height);
	shader_set_uniform_f(shader_get_uniform(shader, "u_shift"), viewport_shift_x * 0.01, viewport_shift_y * 0.01);
	shader_set_uniform_f(shader_get_uniform(shader, "u_zoom"), 1 / viewport_zoom);
	shader_set_uniform_f(shader_get_uniform(shader, "u_do_int_scale"), do_integer_scale);
	shader_set_uniform_f(shader_get_uniform(shader, "u_aspect"), real(screen_aspect_ratio));
	shader_set_uniform_f(shader_get_uniform(shader, "u_do_tate"), screen_do_tate);
	shader_set_uniform_f(shader_get_uniform(shader, "u_curvature_amount"), screen_curvature_amount);
	shader_set_uniform_f(shader_get_uniform(shader, "u_do_mask_mirror"), mask_do_mirror);
	shader_set_uniform_f(shader_get_uniform(shader, "u_mask_strength"), mask_strength);
	shader_set_uniform_f(shader_get_uniform(shader, "u_mask_scale"), mask_scale);
	shader_set_uniform_f(shader_get_uniform(shader, "u_mask_repeat_on_three"), (mask_rgbx_repeat_on_threes and (mask_type == spr_mask_rgbx)));
	shader_set_uniform_f(shader_get_uniform(shader, "u_mask_tex_width"), sprite_get_width(mask_type));
	shader_set_uniform_f(shader_get_uniform(shader, "u_mask_do_shadow"), mask_convert_to_shadow);
	shader_set_uniform_f(shader_get_uniform(shader, "u_slot_strength"), mask_slot_strength);
	shader_set_uniform_f(shader_get_uniform(shader, "u_scanline_min"), 1 - scanline_strength);
	shader_set_uniform_f(shader_get_uniform(shader, "u_scanline_bright_fade"), scanline_bright_fade);
	shader_set_uniform_f(shader_get_uniform(shader, "u_scanline_shape"), scanline_shape);
	shader_set_uniform_f(shader_get_uniform(shader, "u_glow_spread"), glow_spread);
	shader_set_uniform_f(shader_get_uniform(shader, "u_glow_gamma"), glow_gamma);
	shader_set_uniform_f(shader_get_uniform(shader, "u_glow_strength"), glow_strength);
	shader_set_uniform_f(shader_get_uniform(shader, "u_input_gamma"), input_gamma);
	shader_set_uniform_f(shader_get_uniform(shader, "u_output_gamma"), output_gamma);
	shader_set_uniform_f(shader_get_uniform(shader, "u_softness"), image_softness);
	shader_set_uniform_f(shader_get_uniform(shader, "u_post_brightness"), post_brightness);
	shader_set_uniform_f(shader_get_uniform(shader, "u_deconvergence"), image_deconvergence);
	shader_set_uniform_f(shader_get_uniform(shader, "u_glow_over_mask"), glow_over_mask);
	shader_set_uniform_f(shader_get_uniform(shader, "u_noise_amount"), image_noise_amount);
	shader_set_uniform_f(shader_get_uniform(shader, "u_border_brightness"), border_brightness * border_brightness);
	shader_set_uniform_f(shader_get_uniform(shader, "u_border_width"), 100 / (border_width + 0.0000000001));
}

crt_apply = function() {
	draw_surface_stretched(my_game_surface, 0, 0, 1920, 1080);
	
	if is_array(gui_user_event) {
		if (not array_contains(gui_user_event, noone)) and (array_length(gui_user_event) == 2) {
			surface_set_target(monitor_surface);
	
			with all {
				if object_index != crt {
					event_perform(crt.gui_user_event[0], crt.gui_user_event[1]);
				}
			}
	
			surface_reset_target();
		}
	}
	/*
	if do_overlay and not overlay_over_screen {
		draw_sprite_stretched(overlay_image, 0, 0, 0, output_width, output_height);
	}*/

	shader_set(shader);

	update_uniforms();

	shader_set_uniform_f(shader_get_uniform(shader, "u_random_seed"), random_range(0.1, 0.9));

	var sampler_id = shader_get_sampler_index(shader, "u_mask_sampler");
	texture_set_stage(sampler_id, sprite_get_texture(mask_type, mask_rgbx_repeat_on_threes));
	gpu_set_tex_repeat_ext(sampler_id, true);
	gpu_set_tex_filter_ext(sampler_id, false);

	sampler_id = shader_get_sampler_index(shader, "u_slot_sampler");
	var source = spr_slot;
	var ind = mask_slot_height;
	texture_set_stage(sampler_id, sprite_get_texture(source, ind));
	gpu_set_tex_repeat_ext(sampler_id, true);
	gpu_set_tex_filter_ext(sampler_id, false);

	var typing_manager = instance_find(oTypingManager, 0);
	var menu_manager = instance_find(oMenuManager, 0);
	if((typing_manager == noone || typing_manager.state != TYPING_STATE.ORIENTATION_VIDEO) &&
	    (!global.ON_MAIN_MENU || menu_manager.show_credits) &&
		instance_number(oEndingManager) == 0) {
		draw_surface_stretched(monitor_surface, 1160, 270, 580, 425);
	}
	shader_reset();
	/*
	if do_overlay and overlay_over_screen {
		draw_sprite_stretched(overlay_image, 0, 0, 0, output_width, output_height);
	}*/

	/*
	draw_text(10, 10, string(fps) + " / " + string(fps_real));
	draw_text(10, 30, string(surface_get_width(application_surface)));
	draw_text(10, 50, string(display_get_gui_width()));
	*/

	if keyboard_check_pressed(vk_escape) {
		game_end();
	}	
}

/*
function get_mouse_coords()
{
    var intScale = 1.0 + (crt.do_integer_scale * (-1.0 + crt.output_height / (crt.game_height * floor(crt.output_height / crt.game_height))));
    
    var aspect = crt.output_width / (crt.output_height * crt.screen_aspect_ratio);
    
	var u = window_mouse_get_x() / crt.output_width;
	var v = window_mouse_get_y() / crt.output_height;
	

	
	u = ((u - 0.5) * intScale / crt.viewport_zoom) + 0.5;
	v = ((v - 0.5) * intScale / crt.viewport_zoom) + 0.5;
	u = ((u - 0.5) * aspect) + 0.5;
	
	u += crt.viewport_shift_x / 100;
	v += crt.viewport_shift_y / 100;
	
	var centered_u = u - 0.5;
	var centered_v = v - 0.5;
    
	var r = point_distance(0, 0, centered_u, centered_v);
	var r2 = r * r;
    
    var distortionFactor = 1.0 + crt.screen_curvature_amount * r2;
    
	u = centered_u * distortionFactor;
	v = centered_v * distortionFactor;
    
    var scaleFactor = 1.0 / (1.0 + crt.screen_curvature_amount * 0.25);
    u *= scaleFactor;
	v *= scaleFactor;
    
	u += 0.5;
	v += 0.5;
	
	u *= crt.game_width;
	v *= crt.game_height;
	
	u += camera_get_view_x(view_get_camera(0));
	v += camera_get_view_y(view_get_camera(0));
    
    return {
		x : u,
		y : v
	};
}
*/