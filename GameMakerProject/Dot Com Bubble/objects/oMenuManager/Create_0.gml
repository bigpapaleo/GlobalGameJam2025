menu_position = 0;
show_credits = false;

function startTheFreakingGame() {
	global.ON_MAIN_MENU = false;
	with(oMainRoomVideoPlayerManager) {
		startVideo(global.video_level1);
	}
	global.GAME_PAUSED = false;
	with(oMoneyTickerManager) {
		audio_stop_all();
		startLevel1();
	}
}

audio_play_sound(music_TitleScreen, 0, false);