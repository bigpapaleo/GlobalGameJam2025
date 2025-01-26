if(global.ON_MAIN_MENU) {
	var typing_manager = instance_find(oTypingManager, 0);
	if(typing_manager != noone && typing_manager.state == TYPING_STATE.IDLE) {	
		if(show_credits) {
			draw_sprite(sTeamPicture, 0, 0, -25);
			draw_set_font(fDOS_Medium);
			draw_set_color(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
		
			draw_sprite_ext(sTitleScreen, 0, 1315, 100, 2.0, 2.0, 0.0, c_white, 1.0);
			
			draw_text_color_outline_short(850, 225, "Programmer - Elliott Ridgway");
			draw_text_color_outline_short(850, 330, "Videographer - Daniel Jackson");
			draw_text_color_outline_short(850, 435, "Writers - Shaun Lamb, Aaron Campbell");
			draw_text_color_outline_short(850, 540, "3D Modeling - Aaron Campbell");
		
			draw_text_color_outline_short(850, 700, "Also starring");
			draw_text_color_outline_short(850, 805, "Brandon Reed");
			draw_text_color_outline_short(850, 880, "Shawn Cassie");
			draw_text_color_outline_short(850, 955, "Isabella Ridgway");
		} else {
			draw_set_font(fDOS_Medium);
			draw_set_color(c_aqua);
		
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_text(760, 425, "> Push Enter");

			draw_set_color(c_white);
			draw_set_font(fDOS_Large);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_sprite_ext(sTitleScreen, 0, 1760, 500, 3.5, 3.5, title_angle, c_white, 1.0);

			draw_set_font(fDOS_Medium);
			if(menu_position == 0) draw_text_color_outline_short(1714, 850, "> PUNCH IN <");
			else draw_text_color_outline_short(1714, 850, "PUNCH IN");
			if(menu_position == 1) draw_text_color_outline_short(1714, 920, "> TEAM PLAYERS <");
			else draw_text_color_outline_short(1714, 920, "TEAM PLAYERS");
			if(menu_position == 2) draw_text_color_outline_short(1714, 990, "> CALL IT A DAY <");
			else draw_text_color_outline_short(1714, 990, "CALL IT A DAY");
			
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text(810, 1020, version);
		}
	}
}