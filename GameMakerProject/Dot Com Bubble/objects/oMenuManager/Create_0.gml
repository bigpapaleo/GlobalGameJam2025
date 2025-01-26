menu_position = -1;
show_credits = false;
version = "v0.2";

title_angle_sin_wave = 0;

function startOrientationVideo() {
	// global.ON_MAIN_MENU = false;
	with(oTypingManager) {
		state = TYPING_STATE.FADE_OUT;
		next_state = NEXT_STATE.START_ORIENTATION_VIDEO;
	}
	audio_stop_all();

}

function startTheFreakingGame() {
	with(oMainRoomVideoPlayerManager) {
		startVideo(global.video_level1);
	}
	global.GAME_PAUSED = false;
	with(oMoneyTickerManager) {
		startLevel1();
	}
}

audio_play_sound(music_TitleScreen, 0, true);