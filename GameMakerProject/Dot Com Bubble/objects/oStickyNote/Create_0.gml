sticky_note_lines = convertSentenceToParagraph(sticky_note_text, 200);
sticky_note_health = 100000;
acceleration = 0;

enum STICKY_NOTE_STATE {
	ENTERING,
	STUCK,
	FALLEN
}

state = STICKY_NOTE_STATE.ENTERING;

start_y = y+50;
end_y = y;
y = start_y;

with(oMoneyTickerManager) {
	if(current_level == 2) {
		sticky_note_health = 3000+irandom(3000);
	} else if(current_level == 3) {
		sticky_note_health = 1000+irandom(5000);
	}
}

var random_sprite = irandom(3);
if(random_sprite == 1) sprite_index = sStickyNoteReminder2;
if(random_sprite == 2) sprite_index = sStickyNoteReminder3;
if(random_sprite == 3) sprite_index = sStickyNoteReminder4;

image_alpha = 0.0;