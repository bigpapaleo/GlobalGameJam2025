// var game_manager = instance_find(oGameManager, 0);

// Debugging
/*
if(keyboard_check_pressed(ord("F"))) {
	video_seek_to(video_get_position() + 2000);
	if(current_commentary != noone) {
		audio_sound_set_track_position(current_commentary, audio_sound_get_track_position(current_commentary) + 2);
	}
	if(current_track != noone) {
		audio_sound_set_track_position(current_track, audio_sound_get_track_position(current_track) + 2);
	}
} else if(keyboard_check_pressed(ord("R"))) {
	video_seek_to(video_get_position() - 2000);
	if(current_commentary != noone) {
		audio_sound_set_track_position(current_commentary, audio_sound_get_track_position(current_commentary) - 2);
	}
	if(current_track != noone) {
		audio_sound_set_track_position(current_track, audio_sound_get_track_position(current_track) + 2);
	}
}
*/

// video_set_volume(100);
manuallySyncAudio();