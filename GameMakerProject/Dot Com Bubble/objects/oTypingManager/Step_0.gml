if(!global.GAME_PAUSED && state == TYPING_STATE.TYPING) {
	if(string_length(domain_name_string) < max_string_length) {
		if(keyboard_check_pressed(ord("A"))) domain_name_string = domain_name_string + "a";
		if(keyboard_check_pressed(ord("B"))) domain_name_string = domain_name_string + "b";
		if(keyboard_check_pressed(ord("C"))) domain_name_string = domain_name_string + "c";
		if(keyboard_check_pressed(ord("D"))) domain_name_string = domain_name_string + "d";
		if(keyboard_check_pressed(ord("E"))) domain_name_string = domain_name_string + "e";
		if(keyboard_check_pressed(ord("F"))) domain_name_string = domain_name_string + "f";
		if(keyboard_check_pressed(ord("G"))) domain_name_string = domain_name_string + "g";
		if(keyboard_check_pressed(ord("H"))) domain_name_string = domain_name_string + "h";
		if(keyboard_check_pressed(ord("I"))) domain_name_string = domain_name_string + "i";
		if(keyboard_check_pressed(ord("J"))) domain_name_string = domain_name_string + "j";
		if(keyboard_check_pressed(ord("K"))) domain_name_string = domain_name_string + "k";
		if(keyboard_check_pressed(ord("L"))) domain_name_string = domain_name_string + "l";
		if(keyboard_check_pressed(ord("M"))) domain_name_string = domain_name_string + "m";
		if(keyboard_check_pressed(ord("N"))) domain_name_string = domain_name_string + "n";
		if(keyboard_check_pressed(ord("O"))) domain_name_string = domain_name_string + "o";
		if(keyboard_check_pressed(ord("P"))) domain_name_string = domain_name_string + "p";
		if(keyboard_check_pressed(ord("Q"))) domain_name_string = domain_name_string + "q";
		if(keyboard_check_pressed(ord("R"))) domain_name_string = domain_name_string + "r";
		if(keyboard_check_pressed(ord("S"))) domain_name_string = domain_name_string + "s";
		if(keyboard_check_pressed(ord("T"))) domain_name_string = domain_name_string + "t";
		if(keyboard_check_pressed(ord("U"))) domain_name_string = domain_name_string + "u";
		if(keyboard_check_pressed(ord("V"))) domain_name_string = domain_name_string + "v";
		if(keyboard_check_pressed(ord("W"))) domain_name_string = domain_name_string + "w";
		if(keyboard_check_pressed(ord("X"))) domain_name_string = domain_name_string + "x";
		if(keyboard_check_pressed(ord("Y"))) domain_name_string = domain_name_string + "y";
		if(keyboard_check_pressed(ord("Z"))) domain_name_string = domain_name_string + "z";
		if(keyboard_check_pressed(ord(chr(190)))) domain_name_string = domain_name_string + ".";
		if(keyboard_check_pressed(ord(chr(191)))) domain_name_string = domain_name_string + "/";
	}

	if(keyboard_check_pressed(vk_backspace)) domain_name_string = string_copy(domain_name_string, 0, string_length(domain_name_string)-1);

	if(keyboard_check_pressed(vk_anykey)) {
		changeHands();
	}

	if(string_ends_with(domain_name_string, ".com") || keyboard_check_pressed(vk_enter)) {
		var reject_reason = checkToAcceptUrl(domain_name_string);
		if(reject_reason == "") {
			submitUrl();
		} else if(reject_reason == "WAIT FOR HR") {
			state = TYPING_STATE.WAIT_FOR_HR;
			audio_play_sound(sndKlaxon, 0, false);
			alarm[2] = 120;
			with(oStockGraph) {
				instance_destroy();
			}
			with(oClock) {
				active = false;
			}
		} else {
			rejectUrl(reject_reason);
		}
	}
}

if(state == TYPING_STATE.FADE_IN) {
	var fade_manager = instance_find(oFadeManager, 0);
	if(fade_manager != noone) {
		fade_manager.fade_level -= 0.025;
		if(fade_manager.fade_level <= 0.0) {
			state = TYPING_STATE.IDLE;
			if(next_state == NEXT_STATE.START_LEVEL_1) {
				with(oMenuManager) {
					startTheFreakingGame();
				}
			}
		}
	}
} else if(state == TYPING_STATE.FADE_OUT) {
	var fade_manager = instance_find(oFadeManager, 0);
	if(fade_manager != noone) {
		fade_manager.fade_level += 0.025;
		if(fade_manager.fade_level >= 1.0) {
			if(next_state == NEXT_STATE.START_ORIENTATION_VIDEO) {
				state = TYPING_STATE.ORIENTATION_VIDEO;
				
				layer_set_visible(layer_get_id("Assets_1"), false);
				layer_set_visible(layer_get_id("Background"), false);
				layer_set_visible(layer_get_id("Backgrounds_3"), false);
				layer_set_visible(layer_get_id("Instances"), false);
				layer_set_visible(layer_get_id("Hands"), false);
				//layer_set_visible(layer_get_id("CRT"), false);
				
				with(oMainRoomVideoPlayerManager) {
					startVideo(global.video_orientation);
				}
				fade_manager.fade_level = 0;
			}
		}
	}
}

if(state == TYPING_STATE.SUCCESS || state == TYPING_STATE.FAILURE) {
	text_shake_x = -5 + irandom(10);
	text_shake_y = -5 + irandom(10);
}

if(!global.GAME_PAUSED && !audio_is_playing(sndOfficeAmbience)) {
	audio_play_sound(sndOfficeAmbience, 0, true);
}