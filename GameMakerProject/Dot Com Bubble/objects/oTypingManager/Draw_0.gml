if(!global.GAME_PAUSED) {
	if(state != TYPING_STATE.WAIT_FOR_HR && state != TYPING_STATE.IDLE) {
		draw_set_font(fTimesNewRoman);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	
		if(state == TYPING_STATE.SUCCESS) {
			draw_set_color($66ff66);
		} else if(state == TYPING_STATE.FAILURE) {
			draw_set_color(c_red);
		} else {
			draw_set_color(c_white);
		}
		draw_text(100+text_shake_x, 400+text_shake_y, domain_name_string + (typing_bar ? "|" : "")); 
	
		draw_set_color(c_white);
		// draw_text(100, 10, "Buy domains for \"" + oMoneyTickerManager.category + "\"");
		draw_text(100, 20, string(array_length(submitted_domains)) + " domains purchased");
	} else if(state == TYPING_STATE.WAIT_FOR_HR) {
		draw_set_color(c_red);
		draw_rectangle(0, 0, 799, 800, false);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_font(fTimesNewRoman);
		draw_text(100, 20, "DO NOT MOVE. PLEASE WAIT FOR HR");
	}
}
// Draw history.
/*
for(var i = 0; i < array_length(submitted_domains); i++) {
	draw_text(1459, 191 - (i*30), submitted_domains[array_length(submitted_domains)-i-1]);
}
*/