if(global.ON_MAIN_MENU) {
	if(!show_credits) {
		if(keyboard_check_pressed(vk_up) && menu_position > 0) {
			menu_position--;
		} else if(keyboard_check_pressed(vk_down) && menu_position < 2) {
			menu_position++;
		} else if(keyboard_check_pressed(vk_enter)) {
			if(menu_position == 0) startTheFreakingGame();
			else if(menu_position == 1) show_credits = true;
			else if(menu_position == 2) game_end();
		}
	} else {
		if(keyboard_check_pressed(vk_anykey)) {
			show_credits = false;
			menu_position = 0;
		}
	}
}