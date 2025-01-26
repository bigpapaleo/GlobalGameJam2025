function startVideo(videoConst) {
	instance_create_layer(0, 0, "Video", oVideo, {
		video_name : videoConst
	});
}

alarm[0] = 600 + irandom(600);