var _videoData = video_draw();
var _videoStatus = _videoData[0];
if(_videoStatus == 0) {
	if(video_ready) {
		draw_surface(_videoData[1], surface_x, surface_y);
	}
} else {
	exitFromVideoEnd();
}