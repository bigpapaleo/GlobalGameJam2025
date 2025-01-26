if(!global.GAME_PAUSED) {
	var typing_manager = instance_find(oTypingManager, 0);
	if(typing_manager.state != TYPING_STATE.WAIT_FOR_HR && typing_manager.state != TYPING_STATE.IDLE) {
		draw_set_color($66ff66);
		draw_set_font(fTimesNewRoman);
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
		draw_text(754, 20, "$"+string(floor(money_amt)));
		// draw_text(1683, 345, string(money_amt / money_goal * 100) + "% of goal");
	
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		for(var i = 0; i < 3; i++) {
			for(var j = 0; j < 5; j++) {
				draw_line(100 + (i*225), 100 + (j*40), 300 + (i*225), 100 + (j*40));
			
				var index = i*5 + j;
				if(index < array_length(discovered_words)) {
					draw_set_halign(fa_left);
					draw_set_valign(fa_bottom);
					var discovered_word = discovered_words[index];
					draw_text(100 + (i*225), 95 + (j*40), discovered_word);
				
					draw_set_halign(fa_right);
					var index_of_discovered_word = getRateIndexOfDiscoveredWord(discovered_word);				
					draw_text(305 + (i*225), 95 + (j*40), "x"+string(index_of_discovered_word));
				}
			}
		}
	}
}