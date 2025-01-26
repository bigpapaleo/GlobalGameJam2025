if(!global.GAME_PAUSED) {
	draw_set_color(c_black);
	draw_rectangle(x, y, x+300, y-100, true);
	for(var i = 0; i < array_length(y_positions); i++) {
		draw_sprite(sStockPixel, 0, x+(5*i), y-(y_positions[i]));
	}
	
	draw_set_font(fTimesNewRoman);
	draw_set_color($66ff66);
	draw_set_font(fTimesNewRoman);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(x+10, y-90, string(floor(pct_complete*100))+"%");
}