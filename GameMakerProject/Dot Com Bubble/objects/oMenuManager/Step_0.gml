if(global.ON_MAIN_MENU) {
	var typing_manager = instance_find(oTypingManager, 0);
	if(typing_manager != noone && typing_manager.state == TYPING_STATE.IDLE) {
		if(!show_credits) {
			if(keyboard_check_pressed(vk_up) && menu_position > 0) {
				menu_position--;
				audio_play_sound(sndType1, 0, false);
			} else if(keyboard_check_pressed(vk_down) && menu_position < 2) {
				menu_position++;
				audio_play_sound(sndType1, 0, false);
			} else if(keyboard_check_pressed(vk_enter)) {
				if(menu_position == 0) startOrientationVideo();
				else if(menu_position == 1) {
					audio_play_sound(sndSuccess8, 0, false);
					show_credits = true;
				}
				else if(menu_position == 2) game_end();
			}
		} else {
			if(keyboard_check_pressed(vk_anykey)) {
				show_credits = false;
				menu_position = 0;
			}
		}
		
		if(menu_position < 0) menu_position = 0;
	}
	
	title_angle_sin_wave = (title_angle_sin_wave+5)%360;
	title_angle = 5*sin(degtorad(title_angle_sin_wave));
}