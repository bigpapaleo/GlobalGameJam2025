if(!global.ON_MAIN_MENU) {
	draw_self();
	draw_set_color(c_black);
	draw_sprite_ext(sClockHand, 0, x, y, 1.0, 1.0, angle+90, c_white, 1.0);
	//draw_line(x,y,end_x,end_y);
}