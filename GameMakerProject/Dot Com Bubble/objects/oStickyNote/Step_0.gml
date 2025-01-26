if(state == STICKY_NOTE_STATE.ENTERING) {
	y = lerp(y,end_y, 0.25);
	if(abs(y-end_y) < 0.001) {
		state = STICKY_NOTE_STATE.STUCK;
		y = end_y;
	}
} else if(state == STICKY_NOTE_STATE.STUCK) {
	sticky_note_health--;
	if(sticky_note_health == 0) {
		state = STICKY_NOTE_STATE.FALLEN;
	}
} else if(state == STICKY_NOTE_STATE.FALLEN) {
	acceleration++;
	y += acceleration;
}

image_alpha += 0.5;