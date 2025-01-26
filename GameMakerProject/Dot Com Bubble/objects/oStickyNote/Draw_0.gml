draw_set_alpha(image_alpha);

draw_self();

draw_set_color(c_black);
draw_set_font(fHandwriting);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for(var i = 0; i < ds_list_size(sticky_note_lines); i++) {
	draw_text(x,y+25+i*30,ds_list_find_value(sticky_note_lines, i));
}

draw_set_alpha(1.0);