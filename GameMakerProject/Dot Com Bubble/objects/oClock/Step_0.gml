if(!global.GAME_PAUSED && active) {
	countdown_time--;

	angle = -90 + (countdown_time / countdown_time_max) * 360;
	end_x = x-(radius*cos(degtorad(angle)));
	end_y = y+(radius*sin(degtorad(angle)));
	
	if(countdown_time <= 0) {
		state = TYPING_STATE.IDLE;
		with(oMainRoomVideoPlayerManager) {
			startVideo(global.video_ending_good2);
		}
		with(oStockGraph) {
			instance_destroy();
		}
		active = false;
	}
}