if(put_away) {
	acceleration++;
	y += acceleration;
	if(y > room_height + 500) {
		instance_destroy();
	}
} else {
	start_offset_y = lerp(start_offset_y, base_position_y, 0.25);
	y = start_offset_y;
	if(abs(start_offset_y - base_position_y) < 0.001) {
		start_offset_y = base_position_y;
	}
}