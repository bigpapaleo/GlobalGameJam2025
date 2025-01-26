function startVideo(videoConst) {
	instance_create_layer(0, 0, "Video", oVideo, {
		video_name : videoConst
	});
}