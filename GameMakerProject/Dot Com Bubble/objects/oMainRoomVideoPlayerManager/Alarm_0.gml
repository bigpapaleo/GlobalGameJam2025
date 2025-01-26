alarm[0] = 600 + irandom(600);
var typing_manager = instance_find(oTypingManager, 0);
if(typing_manager != noone && typing_manager.state == TYPING_STATE.TYPING) {
	with(oVideo) {
		exitFromVideoEnd();
	}
	
	var random_distraction_video = irandom(17);
	if(random_distraction_video == 0) startVideo(global.video_wastetime_brandon1);
	if(random_distraction_video == 1) startVideo(global.video_wastetime_brandon2);
	if(random_distraction_video == 2) startVideo(global.video_wastetime_brandon3);
	if(random_distraction_video == 3) startVideo(global.video_wastetime_brandon4);
	if(random_distraction_video == 4) startVideo(global.video_wastetime_brandon5);
	if(random_distraction_video == 5) startVideo(global.video_wastetime_brandon6);
	if(random_distraction_video == 6) startVideo(global.video_wastetime_shawn1);
	if(random_distraction_video == 7) startVideo(global.video_wastetime_shawn2);
	if(random_distraction_video == 8) startVideo(global.video_wastetime_shawn3);
	if(random_distraction_video == 9) startVideo(global.video_wastetime_shawn4);
	if(random_distraction_video == 10) startVideo(global.video_wastetime_shawn5);
	if(random_distraction_video == 11) startVideo(global.video_wastetime_shawn6);
	if(random_distraction_video == 12) startVideo(global.video_wastetime_shawn7);
	if(random_distraction_video == 13) startVideo(global.video_wastetime_shawn8);
	if(random_distraction_video == 14) startVideo(global.video_wastetime_shawn9);
	if(random_distraction_video == 15) startVideo(global.video_wastetime_shawn10);
	if(random_distraction_video == 16) startVideo(global.video_wastetime_shawn11);
	if(random_distraction_video == 17) startVideo(global.video_wastetime_shawn12);
}