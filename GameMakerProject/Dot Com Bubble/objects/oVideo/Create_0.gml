video = video_open(video_name);
video_enable_loop(false);
video_set_volume(0);

current_video_name = video_name;
next_video_name = "";

video_ready = false;
// video_stopped = false;
// video_paused = false;
// video_check_for_ending = 0;

should_go_to_main_menu_at_end = false;
should_go_to_win_screen_at_end = false;

current_volume = 100;

current_track = noone;

///////////

function manuallySyncAudio() {
	var video_position = video_get_position();
	var audio_position = -1;
	
	if(current_track != noone) {
		audio_position = audio_sound_get_track_position(current_track) * 1000;
	}
	
	if(audio_position != -1) {
		if(video_position - audio_position > 100) {
			show_debug_message("Video ahead of audio... attempting to rectify...");
			// video_seek_to(audio_position);
		} else if(audio_position - video_position > 100) {
			show_debug_message("Audio ahead of video... attempting to rectify...");
			audio_sound_set_track_position(current_track, video_position / 1000);
		}
	}
}
/*
function customVideoSkipToPoint() {
	var game_manager = instance_find(oGameManager, 0);
	if(room == credits && video_get_position() < 51500) {
		video_seek_to(51501);
		if(global.AUDIO_COMMENTARY && current_commentary != noone) {
			audio_sound_set_track_position(current_commentary, 51.501);
		} else {
			audio_sound_set_track_position(current_track, 51.501);
		}

	} else if(room == theater && global.LAST_DEATH_POINT != 0 && game_manager.time_ms < 1000) {		
		var recover_time_1_ms = game_manager.choice1_time_ms - 10000;
		var recover_time_2_ms = game_manager.choice2_time_ms - 10000;
		var recover_time_3_ms = game_manager.choice3_time_ms - 10000;
		var recover_time_4_ms = game_manager.choice4_time_ms - 10000;
	
		if(global.LAST_DEATH_POINT == 1 && video_get_position() < recover_time_1_ms) {
			video_seek_to(recover_time_1_ms + 1);
			if(global.AUDIO_COMMENTARY) audio_sound_set_track_position(current_commentary, recover_time_1_ms / 1000);
			else audio_sound_set_track_position(current_track, recover_time_1_ms / 1000);
			
		} else if(global.LAST_DEATH_POINT == 2 && video_get_position() < recover_time_2_ms) {
			video_seek_to(recover_time_2_ms + 1);
			if(global.AUDIO_COMMENTARY) audio_sound_set_track_position(current_commentary, recover_time_2_ms / 1000);
			else audio_sound_set_track_position(current_track, recover_time_2_ms / 1000);
			
		} else if(global.LAST_DEATH_POINT == 3 && video_get_position() < recover_time_3_ms) {
			video_seek_to(recover_time_3_ms + 1);
			if(global.AUDIO_COMMENTARY) audio_sound_set_track_position(current_commentary, recover_time_3_ms / 1000);
			else audio_sound_set_track_position(current_track, recover_time_3_ms / 1000);
			
		} else if(global.LAST_DEATH_POINT == 4 && video_get_position() < recover_time_4_ms) {
			video_seek_to(recover_time_4_ms + 1);
			if(global.AUDIO_COMMENTARY) audio_sound_set_track_position(current_commentary, recover_time_4_ms / 1000);
			else audio_sound_set_track_position(current_track, recover_time_4_ms / 1000);
			
		}
	}
}
*/
function stopAllTracks() {
	/*
	audio_stop_sound(sndMain);
	audio_stop_sound(sndKillEnding);
	audio_stop_sound(sndLawnEnding);
	audio_stop_sound(sndRunEnding);
	audio_stop_sound(sndStringEnding);
	audio_stop_sound(sndTouchCatEnding);
	*/
}

function loadAudioTrack(video_name) {
	stopAllTracks();
	
	current_track = noone;
	if(video_name == global.video_level1 && !audio_is_playing(audio_Core_Level1_Intro)) {
		current_track = audio_play_sound(audio_Core_Level1_Intro, 0, false);
	} else if(video_name == global.video_level2 && !audio_is_playing(audio_Core_Level2_Intro)) {
		current_track = audio_play_sound(audio_Core_Level2_Intro, 0, false);		
	} else if(video_name == global.video_level3 && !audio_is_playing(audio_Core_Level3_Intro)) {
		current_track = audio_play_sound(audio_Core_Level3_Intro, 0, false);		
	} else if(video_name == global.video_ending_good && !audio_is_playing(audio_Core_GoodEnding1)) {
		current_track = audio_play_sound(audio_Core_GoodEnding1, 0, false);		
	} else if(video_name == global.video_ending_good2 && !audio_is_playing(audio_Core_GoodEnding2)) {
		current_track = audio_play_sound(audio_Core_GoodEnding2, 0, false);		
	} else if(video_name == global.video_ending_naughty && !audio_is_playing(audio_Core_NaughtyEnding)) {
		current_track = audio_play_sound(audio_Core_NaughtyEnding, 0, false);		
	} else if(video_name == global.video_orientation && !audio_is_playing(audio_Orientation)) {
		current_track = audio_play_sound(audio_Orientation, 0, false);		
	} else if(video_name == global.video_wastetime_brandon1 && !audio_is_playing(audio_WasteTime_Brandon1)) {
		current_track = audio_play_sound(audio_WasteTime_Brandon1, 0, false);		
	} else if(video_name == global.video_wastetime_brandon2 && !audio_is_playing(audio_WasteTime_Brandon2)) {
		current_track = audio_play_sound(audio_WasteTime_Brandon2, 0, false);		
	} else if(video_name == global.video_wastetime_brandon3 && !audio_is_playing(audio_WasteTime_Brandon3)) {
		current_track = audio_play_sound(audio_WasteTime_Brandon3, 0, false);		
	} else if(video_name == global.video_wastetime_brandon4 && !audio_is_playing(audio_WasteTime_Brandon4)) {
		current_track = audio_play_sound(audio_WasteTime_Brandon4, 0, false);		
	} else if(video_name == global.video_wastetime_brandon5 && !audio_is_playing(audio_WasteTime_Brandon5)) {
		current_track = audio_play_sound(audio_WasteTime_Brandon5, 0, false);		
	} else if(video_name == global.video_wastetime_brandon6 && !audio_is_playing(audio_WasteTime_Brandon6)) {
		current_track = audio_play_sound(audio_WasteTime_Brandon6, 0, false);		
	} else if(video_name == global.video_wastetime_shawn1 && !audio_is_playing(audio_WasteTime_Shawn1)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn1, 0, false);		
	} else if(video_name == global.video_wastetime_shawn2 && !audio_is_playing(audio_WasteTime_Shawn2)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn2, 0, false);		
	} else if(video_name == global.video_wastetime_shawn3 && !audio_is_playing(audio_WasteTime_Shawn3)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn3, 0, false);		
	} else if(video_name == global.video_wastetime_shawn4 && !audio_is_playing(audio_WasteTime_Shawn4)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn4, 0, false);		
	} else if(video_name == global.video_wastetime_shawn5 && !audio_is_playing(audio_WasteTime_Shawn5)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn5, 0, false);		
	} else if(video_name == global.video_wastetime_shawn6 && !audio_is_playing(audio_WasteTime_Shawn6)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn6, 0, false);		
	} else if(video_name == global.video_wastetime_shawn7 && !audio_is_playing(audio_WasteTime_Shawn7)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn7, 0, false);		
	} else if(video_name == global.video_wastetime_shawn8 && !audio_is_playing(audio_WasteTime_Shawn8)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn8, 0, false);		
	} else if(video_name == global.video_wastetime_shawn9 && !audio_is_playing(audio_WasteTime_Shawn9)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn9, 0, false);		
	} else if(video_name == global.video_wastetime_shawn10 && !audio_is_playing(audio_WasteTime_Shawn10)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn10, 0, false);		
	} else if(video_name == global.video_wastetime_shawn11 && !audio_is_playing(audio_WasteTime_Shawn11)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn11, 0, false);		
	} else if(video_name == global.video_wastetime_shawn12 && !audio_is_playing(audio_WasteTime_Shawn12)) {
		current_track = audio_play_sound(audio_WasteTime_Shawn12, 0, false);		
	} 
}

function exitFromVideoEnd() {
	video_close();
	if(current_track != noone) audio_stop_sound(current_track);
	instance_destroy();
	/*
	if(should_go_to_main_menu_at_end) {
		room_goto(menu);
	} else {
		global.LAST_DEATH_POINT = 0;
		room_goto(messageToPlayer);
	}
	*/
}

/////////////

// loadAudioTrack(current_video_name);