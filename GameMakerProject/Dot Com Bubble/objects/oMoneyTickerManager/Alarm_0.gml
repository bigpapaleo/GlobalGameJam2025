if(current_level == 1) {
	with(oMainRoomVideoPlayerManager) {
		startVideo(global.video_level2);
	}
} else if(current_level == 2) {
	with(oMainRoomVideoPlayerManager) {
		startVideo(global.video_level3);
	}
} else if(current_level == 3) {
	/*
	with(oMainRoomVideoPlayerManager) {
		startVideo(global.video_ending_good);
	}*/
	goToEndScreen();
}